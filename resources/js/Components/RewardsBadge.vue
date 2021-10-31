<template>
    <div class="flex gap-2 items-center">
        <svg :class="iconSize" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="300px"
             height="300px" viewBox="0 0 300 300" enable-background="new 0 0 300 300"
             xml:space="preserve">
            <g><ellipse fill="#FFC843" cx="149.833" cy="149.501" rx="147.833" ry="146.166"/><ellipse fill="#D38700" cx="150" cy="150.168" rx="113.667" ry="113.833"/>
                <polygon fill="#FFC843" points="192.716,211.945 151.021,190.203 109.476,212.222 117.27,165.852 83.489,133.142 129.999,126.226
                                            150.667,83.991 171.618,126.086 218.172,132.693 184.611,165.626"/></g>
        </svg>
        <span :class="textColor" class="font-semibold ">{{ points }} XP</span>
    </div>
</template>
<script>
    export default {
        name: 'RewardBadge',
        props: {
            points: {
                type: [Number, String],
                default: 0,
            },
            textColor: {
                type: String,
                default: 'text-gray-400'
            },
            iconSize: {
                type: String,
                default: 'w-7 h-7'
            }
        }
    }
</script>
