require('./bootstrap');

// Import modules...
import Vue from 'vue';
import Vuex from 'vuex';
import NProgress from 'nprogress';
import { Inertia } from '@inertiajs/inertia';
import { App as InertiaApp, plugin as InertiaPlugin } from '@inertiajs/inertia-vue';
import PortalVue from 'portal-vue';
import PrimeVue from 'primevue/config';
import VueClipboard from 'vue-clipboard2';
import ToastService from 'primevue/toastservice';
import VueGoodTablePlugin from 'vue-good-table';
import ConfirmationService from 'primevue/confirmationservice';
import Vuelidate from 'vuelidate';
import VueMeta from 'vue-meta';
import store from './Store';
import VueCtkDateTimePicker from 'vue-ctk-date-time-picker';
import vSelect from 'vue-select'

Vue.component('v-select', vSelect)
Vue.component('VueCtkDateTimePicker', VueCtkDateTimePicker);
Vue.use(Vuex);
Vue.use(InertiaPlugin);
Vue.use(PortalVue);
Vue.use(PrimeVue);
Vue.use(ToastService);
Vue.use(ConfirmationService);
Vue.use(VueGoodTablePlugin);
Vue.use(VueClipboard);
Vue.use(Vuelidate);
Vue.use(VueMeta, {
    refreshOnceOnNavigation: true
});

Vue.config.productionTip = false;

Vue.mixin({ methods: { route } });

Vue.mixin(require('./Mixins/translate'));

Vue.filter('convertToCharacter', function (value) {
    let characters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
    return characters[value];
});

NProgress.configure({
    template: '<div class="bar" role="bar"><div class="peg"></div></div>' +
        '<div class="spinner" role="spinner">' +
        '<div class="bg-green-700 rounded-sm shadow flex items-center justify-center gap-4 px-3 py-1">' +
        '<div class="spinner-icon"></div><div class="text-xs text-white">Loading</div>' +
        '</div></div>'
});

const app = document.getElementById('app');

let timeout = null;

Inertia.on('start', () => {
    timeout = setTimeout(() => NProgress.start(), 250)
});

Inertia.on('progress', (event) => {
    if (NProgress.isStarted() && event.detail.progress.percentage) {
        NProgress.set((event.detail.progress.percentage / 100) * 0.9)
    }
});

Inertia.on('finish', (event) => {
    clearTimeout(timeout)
    if (!NProgress.isStarted()) {
        return
    } else if (event.detail.visit.completed) {
        NProgress.done()
    } else if (event.detail.visit.interrupted) {
        NProgress.set(0)
    } else if (event.detail.visit.cancelled) {
        NProgress.done()
        NProgress.remove()
    }
});

window.App = new Vue({
    store,
    metaInfo: {
        title: '',
        titleTemplate: '%s'
    },
    render: (h) =>
        h(InertiaApp, {
            props: {
                initialPage: JSON.parse(app.dataset.page),
                resolveComponent: (name) => require(`./Pages/${name}`).default,
            },
        }),
}).$mount(app);
