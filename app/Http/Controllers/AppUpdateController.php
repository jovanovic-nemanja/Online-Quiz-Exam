<?php

namespace App\Http\Controllers;

use App\Models\PracticeSession;
use App\Models\QuizSession;
use App\Repositories\UserPracticeSetRepository;
use App\Repositories\UserQuizRepository;
use Jackiedo\DotenvEditor\Exceptions\KeyNotFoundException;
use Jackiedo\DotenvEditor\Facades\DotenvEditor;
use Artisan;

class AppUpdateController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin']);
    }

    /**
     * Update env file, configure storage and cache after update
     * The following logic may be different from version to version.
     *
     * @param UserQuizRepository $quizRepository
     * @param UserPracticeSetRepository $setRepository
     * @return \Illuminate\Http\RedirectResponse
     */
    public function onSuccessfulUpdate(UserQuizRepository $quizRepository, UserPracticeSetRepository $setRepository)
    {
        //Check app is installed properly
        $installed = file_exists(storage_path('installed'));
        $env = DotenvEditor::load();

        try {
            $currentVersion = $env->getValue('APP_VERSION');
        } catch (KeyNotFoundException $exception) {
            return redirect()->back()->with('errorMessage', 'Unable to find current version. Please check APP_VERSION in .env file is set to the current version.');
        }

        // check if app is already updated
        if($currentVersion == '1.1.0') {
            return redirect()->back()->with('successMessage', 'App is already up to date');
        }

        $canUpdate = $currentVersion == '1.0.0';

        // If installed and not updated, continue to update
        if($installed && $canUpdate) {

            //Re-evaluate quiz session results
            $qs = QuizSession::with('quiz')->get();
            foreach ($qs as $session) {
                $session->results = $quizRepository->sessionResults($session, $session->quiz);
                $session->save();
            }

            //Re-evaluate practice session results
            $ps = PracticeSession::with('practiceSet')->get();
            foreach ($ps as $session) {
                $session->results = $setRepository->sessionAnalytics($session, $session->practiceSet->total_questions);
                $session->save();
            }

            //Update new app version
            $env->setKey('APP_VERSION', '1.1.0');
            $env->save();

            Artisan::call('config:clear');
            Artisan::call('cache:clear');
            Artisan::call('storage:link');

            return redirect()->back()->with('successMessage', 'App Successfully Updated');
        }

        return redirect()->back()->with('errorMessage', 'Nothing to update');
    }
}
