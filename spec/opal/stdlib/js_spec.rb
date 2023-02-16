require 'spec_helper'
require 'js/raw'

describe 'javascript operations using JS::Raw module' do
  it 'JS::Raw.typeof uses typeof to return underlying javascript type' do
    [1, `null`, `undefined`, Object.new, [], ""].each do |v|
      JS::Raw.typeof(v).should == `typeof #{v}`
    end
  end

  it 'JS::Raw.new uses new to create new instance' do
    f = `function(){}`
    f.JS[:prototype].JS[:color] = 'black'
    JS::Raw.new(f).JS[:color].should == 'black'
  end

  it 'JS::Raw.new handles blocks' do
    f = `function(a){this.a = a}`
    JS::Raw.new(f){1}.JS.a.should == 1
  end

  it 'JS::Raw.instanceof uses instanceof to check if value is an instance of a function' do
    f = `function(){}`
    JS::Raw.instanceof(JS::Raw.new(f), f).should == true
    JS::Raw.instanceof(JS::Raw.new(f), `function(){}`).should == false
  end

  it 'JS::Raw.delete uses delete to remove properties from objects' do
    f = `{a:1}`
    f.JS[:a].should == 1
    JS::Raw.delete(f, :a)
    `#{f.JS[:a]} === undefined`.should == true
  end

  it 'JS::Raw.in uses in to check for properties in objects' do
    f = `{a:1}`
    JS::Raw.in(:a, f).should == true
    JS::Raw.in(:b, f).should == false
  end

  it 'JS::Raw.void returns undefined' do
    f = 1
    `#{JS::Raw.void(f += 1)} === undefined`.should == true
    f.should == 2
  end

  it 'JS::Raw.call calls global javascript methods' do
    JS::Raw.call(:parseFloat, '1.0').should == 1
    JS::Raw.call(:parseInt, '1').should == 1
    JS::Raw.call(:eval, "({a:1})").JS[:a].should == 1
  end

  it 'JS::Raw.method_missing calls global javascript methods' do
    JS::Raw.parseFloat('1.0').should == 1
    JS::Raw.parseInt('1').should == 1
  end

  it 'JS::Raw.call calls global javascript methods with blocks' do
    begin
      JS::Raw.global.JS[:_test_global_function] = lambda{|pr| pr.call + 1}
      JS::Raw._test_global_function{1}.should == 2
    ensure
      JS::Raw.delete(JS::Raw.global, :_test_global_function)
    end
  end

  it 'JS.<METHOD> supports complex method calls' do
    obj = `{ foo: function(){return "foo"} }`
    args = [1,2,3]
    obj.JS.foo(*args).should == :foo
  end
end
