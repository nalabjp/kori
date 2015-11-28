require 'test_helper'
require 'support/kori_creator'

class KoriTest < Minitest::Test
  KORI1 = KoriCreator.from_hash
  KORI2 = KoriCreator.from_yaml
  KORI3 = KoriCreator.from_yaml_on_rails

  def test_public_initializer
    assert !Kori.respond_to?(:[])
    assert !Kori.respond_to?(:new)
    assert Kori.respond_to?(:create)
    assert Kori.respond_to?(:freeze)
  end

  def test_failure_of_not_found_key
    assert_nil KORI1['not_found_key']
    assert_raises(KeyError) { KORI1.fetch('not_found_key') }
  end

  def test_failure_of_invalid_type_of_argument
    assert_raises(ArgumentError) { Kori.freeze(['foo', 'bar']) }
  end

  def test_freeze_from_hash
    assert KORI1.frozen?
    assert KORI1.instance_of?(Kori)

    assert_equal 1, KORI1.a
    assert_equal 1, KORI1[:a]
    assert_equal 1, KORI1['a']
    assert_equal 1, KORI1.fetch(:a)
    assert KORI1.a.frozen?
    assert KORI1.a.instance_of?(Fixnum)

    assert_equal 'xxx', KORI1.b
    assert_equal 'xxx', KORI1[:b]
    assert_equal 'xxx', KORI1['b']
    assert_equal 'xxx', KORI1.fetch(:b)
    assert KORI1.b.frozen?
    assert KORI1.b.instance_of?(String)

    assert_equal [{d:'yyy'},[2,'3']], KORI1.c
    assert_equal [{d:'yyy'},[2,'3']], KORI1[:c]
    assert_equal [{d:'yyy'},[2,'3']], KORI1['c']
    assert_equal [{d:'yyy'},[2,'3']], KORI1.fetch(:c)
    assert KORI1.c.frozen?
    assert KORI1.c.instance_of?(Array)

    assert_equal ({d:'yyy'}), KORI1.c[0]
    assert_equal ({d:'yyy'}), KORI1[:c][0]
    assert_equal ({d:'yyy'}), KORI1['c'][0]
    assert_equal ({d:'yyy'}), KORI1.fetch(:c)[0]
    assert KORI1.c[0].frozen?
    assert KORI1.c[0].instance_of?(Kori)

    assert_equal 'yyy', KORI1.c[0].d
    assert_equal 'yyy', KORI1[:c][0][:d]
    assert_equal 'yyy', KORI1['c'][0]['d']
    assert_equal 'yyy', KORI1.fetch(:c)[0].fetch(:d)
    assert KORI1.c[0].d.frozen?
    assert KORI1.c[0].d.instance_of?(String)

    assert_equal [2,'3'], KORI1.c[1]
    assert_equal [2,'3'], KORI1[:c][1]
    assert_equal [2,'3'], KORI1['c'][1]
    assert_equal [2,'3'], KORI1.fetch(:c)[1]
    assert KORI1.c[1].frozen?
    assert KORI1.c[1].instance_of?(Array)

    assert_equal 2, KORI1.c[1][0]
    assert_equal 2, KORI1[:c][1][0]
    assert_equal 2, KORI1['c'][1][0]
    assert_equal 2, KORI1.fetch(:c)[1][0]
    assert KORI1.c[1][0].frozen?
    assert KORI1.c[1][0].instance_of?(Fixnum)

    assert_equal '3', KORI1.c[1][1]
    assert_equal '3', KORI1[:c][1][1]
    assert_equal '3', KORI1['c'][1][1]
    assert_equal '3', KORI1.fetch(:c)[1][1]
    assert KORI1.c[1][1].frozen?
    assert KORI1.c[1][1].instance_of?(String)

    assert_equal ({f:{g:'zzz'}}), KORI1.e
    assert_equal ({f:{g:'zzz'}}), KORI1[:e]
    assert_equal ({f:{g:'zzz'}}), KORI1['e']
    assert_equal ({f:{g:'zzz'}}), KORI1.fetch(:e)
    assert KORI1.e.frozen?
    assert KORI1.e.instance_of?(Kori)

    assert_equal ({g:'zzz'}), KORI1.e.f
    assert_equal ({g:'zzz'}), KORI1[:e][:f]
    assert_equal ({g:'zzz'}), KORI1['e']['f']
    assert_equal ({g:'zzz'}), KORI1.fetch(:e).fetch(:f)
    assert KORI1.e.f.frozen?
    assert KORI1.e.f.instance_of?(Kori)

    assert_equal 'zzz', KORI1.e.f.g
    assert_equal 'zzz', KORI1[:e][:f][:g]
    assert_equal 'zzz', KORI1['e']['f']['g']
    assert_equal 'zzz', KORI1.fetch(:e).fetch(:f).fetch(:g)
    assert_equal 'zzz', KORI1.get('e.f.g')
    assert KORI1.e.f.g.frozen?
    assert KORI1.e.f.g.instance_of?(String)

    assert_equal 'Key is no problem even in multi-byte string', KORI1.日本語
    assert_equal 'Key is no problem even in multi-byte string', KORI1[:日本語]
    assert_equal 'Key is no problem even in multi-byte string', KORI1['日本語']
    assert_equal 'Key is no problem even in multi-byte string', KORI1.fetch('日本語')
    assert_equal 'Key is no problem even in multi-byte string', KORI1.get('日本語')
    assert KORI1.日本語.frozen?
    assert KORI1.日本語.instance_of?(String)
  end

  def test_freeze_from_yaml
    assert KORI2.frozen?
    assert KORI2.instance_of?(Kori)

    assert_equal 1, KORI2.a
    assert_equal 1, KORI2[:a]
    assert_equal 1, KORI2['a']
    assert_equal 1, KORI2.fetch(:a)
    assert KORI2.a.frozen?
    assert KORI2.a.instance_of?(Fixnum)

    assert_equal 'xxx', KORI2.b
    assert_equal 'xxx', KORI2[:b]
    assert_equal 'xxx', KORI2['b']
    assert_equal 'xxx', KORI2.fetch(:b)
    assert KORI2.b.frozen?
    assert KORI2.b.instance_of?(String)

    assert_equal [{'d' => 'yyy'},[2,'3']], KORI2.c
    assert_equal [{'d' => 'yyy'},[2,'3']], KORI2[:c]
    assert_equal [{'d' => 'yyy'},[2,'3']], KORI2['c']
    assert_equal [{'d' => 'yyy'},[2,'3']], KORI2.fetch(:c)
    assert KORI2.c.frozen?
    assert KORI2.c.instance_of?(Array)

    assert_equal ({'d' => 'yyy'}), KORI2.c[0]
    assert_equal ({'d' => 'yyy'}), KORI2[:c][0]
    assert_equal ({'d' => 'yyy'}), KORI2['c'][0]
    assert_equal ({'d' => 'yyy'}), KORI2.fetch(:c)[0]
    assert KORI2.c[0].frozen?
    assert KORI2.c[0].instance_of?(Kori)

    assert_equal 'yyy', KORI2.c[0].d
    assert_equal 'yyy', KORI2[:c][0][:d]
    assert_equal 'yyy', KORI2['c'][0]['d']
    assert_equal 'yyy', KORI2.fetch(:c)[0].fetch(:d)
    assert KORI2.c[0].d.frozen?
    assert KORI2.c[0].d.instance_of?(String)

    assert_equal [2,'3'], KORI2.c[1]
    assert_equal [2,'3'], KORI2[:c][1]
    assert_equal [2,'3'], KORI2['c'][1]
    assert_equal [2,'3'], KORI2.fetch(:c)[1]
    assert KORI2.c[1].frozen?
    assert KORI2.c[1].instance_of?(Array)

    assert_equal 2, KORI2.c[1][0]
    assert_equal 2, KORI2[:c][1][0]
    assert_equal 2, KORI2['c'][1][0]
    assert_equal 2, KORI2.fetch(:c)[1][0]
    assert KORI2.c[1][0].frozen?
    assert KORI2.c[1][0].instance_of?(Fixnum)

    assert_equal '3', KORI2.c[1][1]
    assert_equal '3', KORI2[:c][1][1]
    assert_equal '3', KORI2['c'][1][1]
    assert_equal '3', KORI2.fetch(:c)[1][1]
    assert KORI2.c[1][1].frozen?
    assert KORI2.c[1][1].instance_of?(String)

    assert_equal ({'f' => {'g' => 'zzz'}}), KORI2.e
    assert_equal ({'f' => {'g' => 'zzz'}}), KORI2[:e]
    assert_equal ({'f' => {'g' => 'zzz'}}), KORI2['e']
    assert_equal ({'f' => {'g' => 'zzz'}}), KORI2.fetch(:e)
    assert KORI2.e.frozen?
    assert KORI2.e.instance_of?(Kori)

    assert_equal ({'g' => 'zzz'}), KORI2.e.f
    assert_equal ({'g' => 'zzz'}), KORI2[:e][:f]
    assert_equal ({'g' => 'zzz'}), KORI2['e']['f']
    assert_equal ({'g' => 'zzz'}), KORI2.fetch(:e).fetch(:f)
    assert KORI2.e.f.frozen?
    assert KORI2.e.f.instance_of?(Kori)

    assert_equal 'zzz', KORI2.e.f.g
    assert_equal 'zzz', KORI2[:e][:f][:g]
    assert_equal 'zzz', KORI2['e']['f']['g']
    assert_equal 'zzz', KORI2.fetch(:e).fetch(:f).fetch(:g)
    assert_equal 'zzz', KORI2.get('e.f.g')
    assert KORI2.e.f.g.frozen?
    assert KORI2.e.f.g.instance_of?(String)

    assert_equal 'Key is no problem even in multi-byte string', KORI2.日本語
    assert_equal 'Key is no problem even in multi-byte string', KORI2[:日本語]
    assert_equal 'Key is no problem even in multi-byte string', KORI2['日本語']
    assert_equal 'Key is no problem even in multi-byte string', KORI2.fetch('日本語')
    assert_equal 'Key is no problem even in multi-byte string', KORI2.get('日本語')
    assert KORI2.日本語.frozen?
    assert KORI2.日本語.instance_of?(String)
  end

  def test_freeze_from_yaml_on_rails
    assert KORI3.frozen?
    assert KORI3.instance_of?(Kori)

    assert_equal 1, KORI3.a
    assert_equal 1, KORI3[:a]
    assert_equal 1, KORI3['a']
    assert_equal 1, KORI3.fetch(:a)
    assert KORI3.a.frozen?
    assert KORI3.a.instance_of?(Fixnum)

    assert_equal 'test_xxx', KORI3.b
    assert_equal 'test_xxx', KORI3[:b]
    assert_equal 'test_xxx', KORI3['b']
    assert_equal 'test_xxx', KORI3.fetch(:b)
    assert KORI3.b.frozen?
    assert KORI3.b.instance_of?(String)

    assert_equal [{'d' => 'test_yyy'},[2,'3']], KORI3.c
    assert_equal [{'d' => 'test_yyy'},[2,'3']], KORI3[:c]
    assert_equal [{'d' => 'test_yyy'},[2,'3']], KORI3['c']
    assert_equal [{'d' => 'test_yyy'},[2,'3']], KORI3.fetch(:c)
    assert KORI3.c.frozen?
    assert KORI3.c.instance_of?(Array)

    assert_equal ({'d' => 'test_yyy'}), KORI3.c[0]
    assert_equal ({'d' => 'test_yyy'}), KORI3[:c][0]
    assert_equal ({'d' => 'test_yyy'}), KORI3['c'][0]
    assert_equal ({'d' => 'test_yyy'}), KORI3.fetch(:c)[0]
    assert KORI3.c[0].frozen?
    assert KORI3.c[0].instance_of?(Kori)

    assert_equal 'test_yyy', KORI3.c[0].d
    assert_equal 'test_yyy', KORI3[:c][0][:d]
    assert_equal 'test_yyy', KORI3['c'][0]['d']
    assert_equal 'test_yyy', KORI3.fetch(:c)[0].fetch(:d)
    assert KORI3.c[0].d.frozen?
    assert KORI3.c[0].d.instance_of?(String)

    assert_equal [2,'3'], KORI3.c[1]
    assert_equal [2,'3'], KORI3[:c][1]
    assert_equal [2,'3'], KORI3['c'][1]
    assert_equal [2,'3'], KORI3.fetch(:c)[1]
    assert KORI3.c[1].frozen?
    assert KORI3.c[1].instance_of?(Array)

    assert_equal 2, KORI3.c[1][0]
    assert_equal 2, KORI3[:c][1][0]
    assert_equal 2, KORI3['c'][1][0]
    assert_equal 2, KORI3.fetch(:c)[1][0]
    assert KORI3.c[1][0].frozen?
    assert KORI3.c[1][0].instance_of?(Fixnum)

    assert_equal '3', KORI3.c[1][1]
    assert_equal '3', KORI3[:c][1][1]
    assert_equal '3', KORI3['c'][1][1]
    assert_equal '3', KORI3.fetch(:c)[1][1]
    assert KORI3.c[1][1].frozen?
    assert KORI3.c[1][1].instance_of?(String)

    assert_equal ({'f' => {'g' => 'test_zzz'}}), KORI3.e
    assert_equal ({'f' => {'g' => 'test_zzz'}}), KORI3[:e]
    assert_equal ({'f' => {'g' => 'test_zzz'}}), KORI3['e']
    assert_equal ({'f' => {'g' => 'test_zzz'}}), KORI3.fetch(:e)
    assert KORI3.e.frozen?
    assert KORI3.e.instance_of?(Kori)

    assert_equal ({'g' => 'test_zzz'}), KORI3.e.f
    assert_equal ({'g' => 'test_zzz'}), KORI3[:e][:f]
    assert_equal ({'g' => 'test_zzz'}), KORI3['e']['f']
    assert_equal ({'g' => 'test_zzz'}), KORI3.fetch(:e).fetch(:f)
    assert KORI3.e.f.frozen?
    assert KORI3.e.f.instance_of?(Kori)

    assert_equal 'test_zzz', KORI3.e.f.g
    assert_equal 'test_zzz', KORI3[:e][:f][:g]
    assert_equal 'test_zzz', KORI3['e']['f']['g']
    assert_equal 'test_zzz', KORI3.fetch(:e).fetch(:f).fetch(:g)
    assert_equal 'test_zzz', KORI3.get('e.f.g')
    assert KORI3.e.f.g.frozen?
    assert KORI3.e.f.g.instance_of?(String)

    assert_equal 'Key is no problem even in multi-byte string', KORI3.日本語
    assert_equal 'Key is no problem even in multi-byte string', KORI3[:日本語]
    assert_equal 'Key is no problem even in multi-byte string', KORI3['日本語']
    assert_equal 'Key is no problem even in multi-byte string', KORI3.fetch('日本語')
    assert_equal 'Key is no problem even in multi-byte string', KORI3.get('日本語')
    assert KORI3.日本語.frozen?
    assert KORI3.日本語.instance_of?(String)
  end
end
