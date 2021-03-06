{Serenade} = require '../src/serenade'

describe 'Serenade.Collection', ->
  beforeEach ->
    @collection = new Serenade.Collection(['a', 'b', 'c'])

  describe '#get', ->
    it 'gets an item from the collection', ->
      expect(@collection.get(0)).toEqual('a')
      expect(@collection.get(1)).toEqual('b')
      expect(@collection.get(2)).toEqual('c')

  describe '#set', ->
    it 'gets an item in the collection', ->
      expect(@collection.get(0)).toEqual('a')
      @collection.set(0, 'foo')
      expect(@collection.get(0)).toEqual('foo')
    it 'triggers a change event', ->
      @collection.set(0, 'foo')
      expect(@collection).toHaveReceivedEvent('change')
    it 'triggers a specific change event', ->
      @collection.set(1, 'foo')
      expect(@collection).toHaveReceivedEvent('change:1', with: ['foo'])
    it 'triggers a set event', ->
      @collection.set(1, 'foo')
      expect(@collection).toHaveReceivedEvent('set', with: [1, 'foo'])

  describe '#update', ->
    it 'updates length', ->
      @collection.update([1,2])
      expect(@collection.length).toEqual(2)

  describe '#push', ->
    it 'adds an item to the collection', ->
      @collection.push('g')
      expect(@collection.get(3)).toEqual('g')
    it 'triggers a change event', ->
      @collection.push('g')
      expect(@collection).toHaveReceivedEvent('change')
    it 'triggers an add event', ->
      @collection.push('g')
      expect(@collection).toHaveReceivedEvent('add', with: ['g'])

  describe '#indexOf', ->
    it 'returns where in the collection the given item is', ->
      expect(@collection.indexOf('a')).toEqual(0)
      expect(@collection.indexOf('b')).toEqual(1)
    it 'works without native indexOf function', ->
      @collection.list.indexOf = undefined
      expect(@collection.indexOf('a')).toEqual(0)
      expect(@collection.indexOf('b')).toEqual(1)

  describe '#deleteAt', ->
    it 'removes the item from the collection', ->
      @collection.deleteAt(1)
      expect(@collection.get(0)).toEqual('a')
      expect(@collection.get(1)).toEqual('c')
      expect(@collection.get(2)).toEqual(undefined)
    it 'triggers a change event', ->
      @collection.deleteAt(1)
      expect(@collection).toHaveReceivedEvent('change')
    it 'triggers a delete event', ->
      @collection.deleteAt(1)
      expect(@collection).toHaveReceivedEvent('delete', with: [1])

  describe '#delete', ->
    it 'removes the item from the collection', ->
      @collection.delete('b')
      expect(@collection.get(0)).toEqual('a')
      expect(@collection.get(1)).toEqual('c')
      expect(@collection.get(2)).toEqual(undefined)
