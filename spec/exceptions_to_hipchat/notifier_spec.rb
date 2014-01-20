require 'spec_helper'

describe ExceptionsToHipchat::Notifier do
  let(:app) { double('app') }
  let(:room) { double('room') }
  let(:client) { {testing: room } }

  describe 'sending' do
    let(:exception) { Exception.new('Some Exception') }

    it 'sends to hipchat with default options' do
      notifier = ExceptionsToHipchat::Notifier.new(app, {room: :testing}, client)

      room.should_receive(:send).with('Notifier', '[Exception] Some Exception', color: :red, notify: nil)
      app.stub(:call).and_raise(exception)

      expect {notifier.call('env')}.to raise_exception(exception)
    end

    it 'sends to hipchat with a different color' do
      notifier = ExceptionsToHipchat::Notifier.new(app, {room: :testing, color: :purple}, client)

      room.should_receive(:send).with('Notifier', '[Exception] Some Exception', color: :purple, notify: nil)
      app.stub(:call).and_raise(exception)

      expect {notifier.call('env')}.to raise_exception(exception)
    end

    it 'sends to hipchat with a notification' do
      notifier = ExceptionsToHipchat::Notifier.new(app, {room: :testing, notify: true}, client)

      room.should_receive(:send).with('Notifier', '[Exception] Some Exception', color: :red, notify: true)
      app.stub(:call).and_raise(exception)

      expect {notifier.call('env')}.to raise_exception(exception)
    end

    it 'sends to hipchat with a notifier' do
      notifier = ExceptionsToHipchat::Notifier.new(app, {room: :testing, user: 'New Guy'}, client)

      room.should_receive(:send).with('New Guy', '[Exception] Some Exception', color: :red, notify: nil)
      app.stub(:call).and_raise(exception)

      expect {notifier.call('env')}.to raise_exception(exception)
    end

    it 'sends to hipchat with a truncated notifier' do
      notifier = ExceptionsToHipchat::Notifier.new(app, {room: :testing, user: 'New Guyyyyyyyyyyyyyyyyyyyyyy'}, client)

      room.should_receive(:send).with('New Guyyyyyyyy', '[Exception] Some Exception', color: :red, notify: nil)
      app.stub(:call).and_raise(exception)

      expect {notifier.call('env')}.to raise_exception(exception)
    end
  end

  describe 'ignoring' do
    let(:notifier) { ExceptionsToHipchat::Notifier.new(app, {room: :testing, ignore: /Some Exception/}, client) }

    it 'ignores exceptions that match' do
      exception = Exception.new('Some Exception')

      app.stub(:call).and_raise(exception)
      room.should_not_receive(:send)

      expect {notifier.call('env')}.to raise_exception(exception)
    end

    it 'does not ignore exceptions that do not match' do
      exception = Exception.new('Some Other Exception')

      app.stub(:call).and_raise(exception)
      room.should_receive(:send)

      expect {notifier.call('env')}.to raise_exception(exception)
    end
  end
end

