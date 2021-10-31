module.exports = {
    methods: {
        /**
         * Translate the given key.
         */
        __(key, replace = {}) {
            let translation = this.$page.props.translations[key]
                ? this.$page.props.translations[key]
                : key

            Object.keys(replace).forEach(function (key) {
                translation = translation.replace(':' + key, replace[key])
            });

            return translation
        },

        /**
         * Translate the given key with basic pluralization.
         */
        __n(key, number, replace = {}) {
            let options = key.split('|');

            key = options[1];
            if(number === 1) {
                key = options[0];
            }

            return tt(key, replace);
        },
    },
}
