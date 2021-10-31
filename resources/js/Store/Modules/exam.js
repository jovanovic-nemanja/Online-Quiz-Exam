const state = {
    examPatterns: [],
    subCategories: [],
    details: {
        title: '',
        description: '',
        sub_category_id: '',
        exam_type: 1,
        exam_pattern_id: '',
        is_paid: false,
        price: null,
        schedule_type: 1,
        schedule_from: '',
        schedule_to: '',
        is_public: true,
        is_active: true
    },
    pattern: {
        auto_duration: false,
        total_duration: null,
        auto_grading: false,
        total_marks: null,
        is_section_based: false,
        disable_section_navigation: false,
        has_section_cutoff: false,
        has_negative_marking: false,
        negative_marking_type: 'fixed',
        negative_marks: null,
    },
    settings: {
        restrict_attempts: false,
        no_of_attempts: null,
        auto_evaluation: true,
        has_partial_weighting: false,
        disable_question_navigation: false,
        list_questions: false,
        show_marks: true,
        allow_calculator: false,
        allow_instant_score_view: true,
        allow_review: true,
        send_email: false,
        enable_face_verification: false,
        enable_id_proof_verification: false,
        enable_image_proctoring: false,
        image_capture_interval: 60,
        suspend_on_tab_shift: false,
        max_shifting_alerts: 3,
    },
    questions: [],
    users: [],
    sections: [{
        section_id: null,
        section_duration: null,
        section_marks: null,
        section_cutoff: null,
        section_order: 1
    }],
    examTypes: [{name: 'Objective', code: 1},{name: 'Subjective', code: 2},{name: 'Mixed (Objective & Subjective)', code: 3}],
    scheduleTypes: [{name: 'Fixed', code: 1},{name: 'Flexible', code: 2}],
    visibilityTypes: [{name: 'Public', code: true},{name: 'Private', code: false}],
    pricingTypes: [{name: 'Free', code: false},{name: 'Paid', code: true}],
    autoModes: [{name: 'Auto', code: true},{name: 'Manual', code: false}],
    choices: [{name: 'Yes', code: true},{name: 'No', code: false}],
    amountTypes: [{name: 'Fixed', code: 'fixed'},{name: 'Percentage', code: 'percentage'}],
    editorUrl: window.CKEditorURL,
    en: {
        firstDayOfWeek: 0,
        dayNames: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
        dayNamesShort: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
        dayNamesMin: ["Su","Mo","Tu","We","Th","Fr","Sa"],
        monthNames: [ "January","February","March","April","May","June","July","August","September","October","November","December" ],
        monthNamesShort: [ "Jan", "Feb", "Mar", "Apr", "May", "Jun","Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ],
        today: 'Today',
        clear: 'Clear',
        dateFormat: 'mm/dd/yy',
        weekHeader: 'Wk'
    },
    debounce: null
};

const getters = {
    allExamPatterns: state => state.examPatterns,
    allSubCategories: state => state.subCategories
};

const mutations = {
    UPDATE_EXAM_PATTERNS: (state, patterns) => (state.examPatterns = patterns),
    UPDATE_SUB_CATEGORIES: (state, categories) => (state.subCategories = categories),
    UPDATE_DETAILS: function (state, payload) {
        Object.assign(state.details, payload);
    },
    UPDATE_PATTERN: function (state, payload) {
        Object.assign(state.pattern, payload);
    },
    UPDATE_SETTINGS: function (state, payload) {
        Object.assign(state.settings, payload);
    },
    ADD_SECTION: function (state, payload) {
        state.sections.push(payload);
    },
    REMOVE_SECTION: function (state, payload) {
        state.sections.splice(payload, 1);
    },
    UPDATE_SECTION: function (state, payload) {
        Object.assign(state.sections[payload.index], {[payload.field]: payload.value});
    },
    SET_TIMEOUT: (state, method) => (state.debounce = method)
};

const actions = {
    searchSubCategories(context, query) {
        clearTimeout(context.state.debounce);
        context.commit('UPDATE_SUB_CATEGORIES', []);
        context.commit('SET_TIMEOUT', setTimeout(() => {
            axios.get(route('search_sub_categories', {query: query}))
                .then(function (response) {
                    console.log(response);
                    context.commit('UPDATE_SUB_CATEGORIES', response.data.subCategories);
                })
                .catch(function (error) {
                    console.log(error);
                })
                .then(function () {
                    // always executed
                });
        }, 600));
    },
    changeExamType(context, value) {
        context.commit('UPDATE_DETAILS', {exam_type: value});
        if(value !== 1) {
            context.commit('UPDATE_SETTINGS', {auto_evaluation: false});
        }
    },
    addSection(context) {
        context.commit('ADD_SECTION', {
            section_id: null,
            section_duration: null,
            section_marks: null,
            section_cutoff: null,
            section_order: 1
        });
    },
    removeSection(context, value) {
        context.commit('REMOVE_SECTION', value);
    },
};

export default {
    state,
    getters,
    actions,
    mutations
};
