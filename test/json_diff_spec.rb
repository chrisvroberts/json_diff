require 'rspec'
require 'json_diff'
require 'json'

RSpec.describe JSONDiff do
  it "should find no differences in like objects" do
    object_tree_1 = JSON.parse('{"key1": 789, "key2": "val"}')
    object_tree_2 = JSON.parse('{"key1": 789, "key2": "val"}')
    differences = []

    expect(JSONDiff.objects(object_tree_1, object_tree_2)).to eq(differences)
  end

  it "should spot keys missing in lhs" do
    object_tree_1 = JSON.parse('{"key2": "val"}')
    object_tree_2 = JSON.parse('{"key1": 789, "key2": "val"}')
    differences = ["a is missing:   /key1"]

    expect(JSONDiff.objects(object_tree_1, object_tree_2)).to eq(differences)
  end

  it "should spot keys missing in rhs" do
    object_tree_1 = JSON.parse('{"key3": 789, "key2": "val"}')
    object_tree_2 = JSON.parse('{"key2": "val"}')
    differences = ["b is missing:   /key3"]

    expect(JSONDiff.objects(object_tree_1, object_tree_2)).to eq(differences)
  end

  it "should spot keys missing on both sides" do
    object_tree_1 = JSON.parse('{"key3": 789, "key2": "val"}')
    object_tree_2 = JSON.parse('{"key1": 789, "key2": "val"}')
    differences = ["b is missing:   /key3", "a is missing:   /key1"]

    expect(JSONDiff.objects(object_tree_1, object_tree_2)).to eq(differences)
  end

  it "should find differing values of like type in an object" do
    object_tree_1 = JSON.parse('{"key1": 689, "key2": "val"}')
    object_tree_2 = JSON.parse('{"key1": 789, "key2": "val"}')
    differences = ["value mismatch: /key1 '689' != '789'"]

    expect(JSONDiff.objects(object_tree_1, object_tree_2)).to eq(differences)
  end

  it "should find keys with differing value types" do
    object_tree_1 = JSON.parse('{"key1": "9", "key2": "val"}')
    object_tree_2 = JSON.parse('{"key1": 789, "key2": "val"}')
    differences = ["type mismatch:  /key1 'String' != 'Fixnum'"]

    expect(JSONDiff.objects(object_tree_1, object_tree_2)).to eq(differences)
  end

  it "should find keys of like type whose contents differ in type" do
    object_tree_1 = JSON.parse('{"key1": 789, "key2": [123]}')
    object_tree_2 = JSON.parse('{"key1": 789, "key2": ["val"]}')
    differences = ["type mismatch:  /key2[0] 'Fixnum' != 'String'"]

    expect(JSONDiff.objects(object_tree_1, object_tree_2)).to eq(differences)
  end

  it "should find keys of like type whose contents differ in size" do
    object_tree_1 = JSON.parse('{"key1": 789, "key2": [123]}')
    object_tree_2 = JSON.parse('{"key1": 789, "key2": []}')
    differences = ["size mismatch:  /key2"]

    expect(JSONDiff.objects(object_tree_1, object_tree_2)).to eq(differences)
  end

  it "should find multiple differences in an object" do
    object_tree_1 = JSON.parse('{"key1": 789, "key2": [123]}')
    object_tree_2 = JSON.parse('{"key1": 78, "key2": []}')
    differences = ["value mismatch: /key1 '789' != '78'", "size mismatch:  /key2"]

    expect(JSONDiff.objects(object_tree_1, object_tree_2)).to eq(differences)
  end

  it "should find no differences in like arrays" do
    object_tree_1 = JSON.parse('[1, 2, 3]')
    object_tree_2 = JSON.parse('[1, 2, 3]')
    differences = []

    expect(JSONDiff.arrays(object_tree_1, object_tree_2)).to eq(differences)
  end

  it "should find arrays whose sizes differ" do
    object_tree_1 = JSON.parse('[1, 2]')
    object_tree_2 = JSON.parse('[1, 2, 3]')
    differences = ["size mismatch:  /"]

    expect(JSONDiff.arrays(object_tree_1, object_tree_2)).to eq(differences)
  end

  it "should find value mismatches in like sized arrays" do
    object_tree_1 = JSON.parse('[1, 2, 3]')
    object_tree_2 = JSON.parse('[1, 4, 3]')
    differences = ["value mismatch: /[1] '2' != '4'"]

    expect(JSONDiff.arrays(object_tree_1, object_tree_2)).to eq(differences)
  end

  it "should find type mismatches in like sized arrays" do
    object_tree_1 = JSON.parse('[1, 2, 3]')
    object_tree_2 = JSON.parse('[1, 2, []]')
    differences = ["type mismatch:  /[2] 'Fixnum' != 'Array'"]

    expect(JSONDiff.arrays(object_tree_1, object_tree_2)).to eq(differences)
  end

  it "should find value mismatches in nested arrays" do
    object_tree_1 = JSON.parse('[1, 2, [3]]')
    object_tree_2 = JSON.parse('[1, 2, [2]]')
    differences = ["value mismatch: /[2][0] '3' != '2'"]

    expect(JSONDiff.arrays(object_tree_1, object_tree_2)).to eq(differences)
  end
end
