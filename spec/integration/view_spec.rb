require 'rodakase/view'

RSpec.describe 'Rodakase View' do
  let(:view_class) do
    klass = Class.new(Rodakase::View::Layout)

    klass.configure do |config|
      config.root = SPEC_ROOT.join('fixtures/templates')
      config.engine = :slim
      config.name = 'app'
      config.template = 'users'
    end

    klass
  end

  let(:scope) do
    Struct.new(:title).new('Rodakase Rocks!')
  end

  it 'renders within a layout using provided scope' do
    view = view_class.new

    users = [
      { name: 'Jane', email: 'jane@doe.org' },
      { name: 'Joe', email: 'joe@doe.org' }
    ]

    expect(view.(scope: scope, locals: { subtitle: "Users List", users: users })).to eql(
      '<!DOCTYPE html><html><head><title>Rodakase Rocks!</title></head><body><h2>Users List</h2><div class="users"><table><tbody><tr><td>Jane</td><td>jane@doe.org</td></tr><tr><td>Joe</td><td>joe@doe.org</td></tr></tbody></table></div></body></html>'
    )
  end

  it 'renders a view with an alternative format and engine' do
    view = view_class.new

    users = [
      { name: 'Jane', email: 'jane@doe.org' },
      { name: 'Joe', email: 'joe@doe.org' }
    ]

    expect(view.(scope: scope, locals: { subtitle: 'Users List', users: users }, format: 'txt', engine: 'erb').strip).to eql(
      "# Rodakase Rocks!\n\n## Users List\n\n* Jane (jane@doe.org)\n* Joe (joe@doe.org)"
    )
  end

  describe 'inheritance' do
    let(:parent_view) do
      klass = Class.new(Rodakase::View::Layout)

      klass.setting :root, SPEC_ROOT.join('fixtures/templates')
      klass.setting :engine, :slim
      klass.setting :name, 'app'

      klass
    end

    let(:child_view) do
      Class.new(parent_view) do
        configure do |config|
          config.template = 'tasks'
        end
      end
    end

    it 'renders within a parent class layout using provided scope' do
      view = child_view.new

      expect(view.(scope: scope, locals: { tasks: [{ title: 'one' }, { title: 'two' }] })).to eql(
        '<!DOCTYPE html><html><head><title>Rodakase Rocks!</title></head><body><ol><li>one</li><li>two</li></ol></body></html>'
      )
    end
  end
end
