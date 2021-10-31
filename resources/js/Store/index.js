import Vuex from 'vuex';
import Vue from 'vue';
import exam from './Modules/exam';

Vue.use(Vuex);

export default new Vuex.Store({
    modules: {
        exam
    }
})
