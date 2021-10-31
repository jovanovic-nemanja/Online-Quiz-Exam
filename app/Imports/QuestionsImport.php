<?php
/**
 * File name: QuestionsImport.php
 * Last modified: 14/07/21, 10:01 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Imports;

use App\Models\Question;
use Illuminate\Support\Str;
use Maatwebsite\Excel\Concerns\Importable;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithBatchInserts;
use Maatwebsite\Excel\Concerns\WithChunkReading;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;

class QuestionsImport implements ToModel, WithHeadingRow, WithBatchInserts, WithChunkReading, WithValidation
{
    use Importable;

    private $skill;
    private $rows = 0;
    private $questionTypes;
    private $difficultyLevels;

    public function __construct($questionTypes, $difficultyLevels, $skill)
    {
        $this->skill = $skill;
        $this->questionTypes = $questionTypes;
        $this->difficultyLevels = $difficultyLevels;
    }

    /**
     * Import questions from excel
     *
     * @param array $row
     * @return Question
     */
    public function model(array $row)
    {
        ++$this->rows;
        $this->qType = $row['question_type'];

        return new Question([
            'question' => $row['question'],
            'code' => 'que_'.Str::random(11),
            'question_type_id' => $this->questionTypes[$row['question_type']],
            'skill_id' => $this->skill,
            'options' => formatImportOptionsProperty([
                    $row['option1'],
                    $row['option2'],
                    $row['option3'],
                    $row['option4'],
                    $row['option5']
                ], $row['question_type']),
            'correct_answer' => formatImportAnswerProperty($row['correct_answer'], $row['question_type'], $row['question']),
            'default_marks' => $row['default_marks'],
            'default_time' => $row['default_time_to_solve'],
            'difficulty_level_id' => $this->difficultyLevels[$row['difficulty_level']],
            'hint' => $row['hint'],
            'solution' => $row['solution'],
        ]);
    }

    public function rules(): array
    {
        return [
            'question' => ['required'],
            'question_type' => ['required'],
            'default_marks' => ['required'],
            'default_time_to_solve' => ['required'],
            'difficulty_level' => ['required']
        ];
    }

    public function batchSize(): int
    {
        return 100;
    }

    public function chunkSize(): int
    {
        return 100;
    }

    public function getRowCount(): int
    {
        return $this->rows;
    }
}
