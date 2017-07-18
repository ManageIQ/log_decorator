require 'spec_helper'

describe LogDecorator do
  it 'has a version number' do
    expect(LogDecorator::VERSION).not_to be nil
  end

  describe "module methods" do
    it "should respond to :prefix" do
      expect(LogDecorator.respond_to?(:prefix)).to be true
    end

    it "should respond to :prefix=" do
      expect(LogDecorator.respond_to?(:prefix=)).to be true
    end

    it "should respond to :logger" do
      expect(LogDecorator.respond_to?(:logger)).to be true
    end

    it "should respond to :logger=" do
      expect(LogDecorator.respond_to?(:logger=)).to be true
    end
  end

  describe "include in class" do
    before(:each) do
      TestClass1._prefix = LogDecorator::DEFAULT_PREFIX
      TestLog.sio.rewind
    end

    it "should respond to _log class method" do
      expect(TestClass1.respond_to?(:_log)).to be true
    end

    it "should respond to _log instance method" do
      expect(TestClass1.new.respond_to?(:_log)).to be true
    end

    it "should log expected message from class method" do
      TestClass1.cmethod
      TestLog.sio.rewind
      expect(TestLog.sio.gets).to eq("TestClass1.cmethod called\n")
    end

    it "should log expected message from instance method" do
      TestClass1.new.imethod
      TestLog.sio.rewind
      expect(TestLog.sio.gets).to eq("TestClass1#imethod called\n")
    end
  end

  describe "change prefix" do
    before(:each) do
      TestClass1._prefix = lambda do |klass, separator, location|
        "MIQ(#{LogDecorator::DEFAULT_PREFIX.call(klass, separator, location)})"
      end
      TestLog.sio.rewind
    end

    it "should log expected message from class method" do
      TestClass1.cmethod
      TestLog.sio.rewind
      expect(TestLog.sio.gets).to eq("MIQ(TestClass1.cmethod) called\n")
    end

    it "should log expected message from instance method" do
      TestClass1.new.imethod
      TestLog.sio.rewind
      expect(TestLog.sio.gets).to eq("MIQ(TestClass1#imethod) called\n")
    end
  end

  describe "change loglevel" do
    before(:each) do
      TestClass1._prefix = LogDecorator::DEFAULT_PREFIX
      TestClass1._log.level = Log4r::DEBUG
      TestLog.sio.reopen("")
    end

    it "should log expected message from class method at DEBUG" do
      expect(TestClass1._log.debug?).to be true
      TestClass1.cmethod
      TestLog.sio.rewind
      expect(TestLog.sio.gets).to eq("TestClass1.cmethod called\n")
    end

    it "should NOT log expected message from class method at INFO" do
      TestClass1._log.level = Log4r::INFO
      expect(TestClass1._log.info?).to be true
      TestClass1.cmethod
      TestLog.sio.rewind
      expect(TestLog.sio.gets).to be_nil
    end

    it "should log expected message from instance method at DEBUG" do
      TestClass1.new.imethod
      TestLog.sio.rewind
      expect(TestLog.sio.gets).to eq("TestClass1#imethod called\n")
    end

    it "should NOT log expected message from instance method at INFO" do
      obj = TestClass1.new
      obj._log.level = Log4r::INFO
      expect(obj._log.info?).to be true
      obj.imethod
      TestLog.sio.rewind
      expect(TestLog.sio.gets).to be_nil
    end
  end
end
