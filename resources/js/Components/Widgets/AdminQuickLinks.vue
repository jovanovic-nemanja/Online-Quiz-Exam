<template>
    <div class="bg-white rounded p-6 shadow">
        <h4 class="pb-4 text-sm font-semibold uppercase text-gray-800">Quick Links</h4>
        <div class="grid grid-cols-1 sm:grid-cols-2 flex justify-between items-center">
            <ul>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('quizzes.index')">New Quiz Schedule</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('quizzes.create')">Create New Quiz</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('practice-sets.create')">Create Practice Set</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('quizzes.index')">View Quizzes</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('practice-sets.index')">View Practice Sets</inertia-link></li>
            </ul>
            <ul>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('questions.index')">Create New Question</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('initiate_import_questions')">Import Questions</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('comprehensions.index')">Create New Comprehension</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('skills.index')">Create New Skill</inertia-link></li>
                <li class="mb-2"><inertia-link class="qt-link-success" :href="route('topics.index')">Create New Topic</inertia-link></li>
            </ul>
        </div>
    </div>
</template>
