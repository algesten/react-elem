
describe 'wrap', ->

    wrap = require '../src/wrap'

    mkelem = (o) ->
        o.$$typeof = wrap.REACT_ELEMENT_TYPE
        o

    e1 = mkelem {el:1}
    e2 = mkelem {el:2}
    fne1 = wrap -> e1
    fne2 = wrap -> e2

    div = fn = null
    beforeEach ->
        div = wrap fn = spy ->

    TESTS = [
        [[], [null, null], 'no arg']
        [[null], [null, null], 'null']
        [[undefined], [null, null], 'undefined']
        [[undefined, undefined], [null, null], 'undefined, undefined']
        [[undefined, null], [null, null], 'undefined, null']
        [['panda'], [null, 'panda'], 'string']
        [['panda', null], [null, 'panda'], 'string, null']
        [[null, 'panda'], [null, 'panda'], 'null, string']
        [['panda', 'cub'], [null, 'pandacub'], 'string, string']
        [['panda', null, 'cub'], [null, 'pandacub'], 'string, null, string']
        [[{p:1}], [{p:1}, null], 'obj']
        [[{p:1}, {c:2}], [{p:1, c:2}, null], 'obj, obj']
        [['panda', {p:1}, {c:2}], [{p:1, c:2}, 'panda'], 'str, obj, obj']
        [[{class:'b'}], [{className:'b'}, null], 'class to className']
        [[{class:''}], [{className:''}, null], 'empty class to className']
        [[{class:'b'}, {p:2}], [{className:'b', p:2}, null], 'class, obj to className']
        [[{p:null}],[{p:null}, null], 'obj with null']
        [[e1], [null, null, e1], 'elem']
        [[e1, e2], [null, null, e1, e2], 'elem, elem']
        [[{p:1}, e1, e2], [{p:1}, null, e1, e2], 'obj, elem, elem']
        [[e1, {p:1}, e2], [{p:1}, null, e1, e2], 'elem, obj, elem']
        [[[e1]], [null, null, [e1]], '[elem]']
        [[[e1], e2], [null, null, [e1], e2], '[elem], elem']
        [[[e1], [e2]], [null, null, [e1], [e2]], '[elem], [elem]']
        [[[e1], [e2]], [null, null, [e1], [e2]], '[elem], [elem]']
        [[(->fne1())], [null, null, e1], 'fn -> elem']
        [[(->fne1(); fne2())], [null, null, e1, e2], '-> (elem; elem)']
        [[(->fne1()), e2], [null, null, e1, e2], '(-> elem), elem']
        [[(->fne1()), (->fne2())], [null, null, e1, e2], '(-> elem), (-> elem)']
        [[(->fne1(fne2()))], [null, null, e1], '(-> elem(-> elem))']
    ]

    TESTS.forEach (t) ->

        it "handles #{t[2]}", ->
            div t[0]...
            eql fn.args.length, 1
            eql fn.args[0], t[1]
