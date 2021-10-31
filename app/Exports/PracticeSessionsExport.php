<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromArray;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class PracticeSessionsExport implements FromArray, WithHeadings, WithStyles
{
    public array $sessions;
    private string $title;
    private $stats;
    private string $footer;

    public function __construct($stats, array $sessions, String $title, String $footer)
    {
        $this->sessions = $sessions;
        $this->title = $title;
        $this->stats = $stats;
        $this->footer = $footer;
    }

    /**
     * @return array
     */
    public function array(): array
    {
        return $this->sessions;
    }

    public function headings(): array
    {
        return [
            [$this->title],
            [
                "Total Attempts: {$this->stats->total_attempts}",
                "Unique Attempts: {$this->stats->unique_test_takers}",
                "Avg. Time: ".formattedSeconds(round($this->stats->avg_time, 0))['detailed_readable'],
                "Avg. Score: ".round($this->stats->avg_score, 1),
                "High Score: ".round($this->stats->high_score, 1),
                "Low Score: ".round($this->stats->low_score, 1),
                "Avg. Accuracy: ".round($this->stats->avg_accuracy, 0)."%",
                "Avg. Speed: ".round($this->stats->avg_speed, 0)." que/hr",
            ],
            ['Test Takers Progress Report'],
            ['Test Taker', 'Email', 'Completed On', 'Points Earned', 'Accuracy', 'Speed', 'Status', 'Session ID']
        ];
    }

    public function styles(Worksheet $sheet)
    {
        $lastRow = sizeof($this->sessions) + 4;
        $borderStyle = [
            'borders' => [
                'allBorders' => [
                    'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN,
                ],
            ],
        ];
        $headingStyle = [
            'font' => [
                'bold' => true,
            ],
            'alignment' => [
                'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER,
                'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER,
            ],
            'fill' => [
                'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                'startColor' => [
                    'argb' => 'FFD9D9D9',
                ],
            ],
        ];
        $sheet->setTitle("Report");
        $sheet->mergeCells('A1:H1');
        $sheet->mergeCells('A3:H3');

        $sheet->getRowDimension('1')->setRowHeight(30);
        $sheet->getRowDimension('2')->setRowHeight(50);
        $sheet->getRowDimension('3')->setRowHeight(30);
        $sheet->getRowDimension('4')->setRowHeight(30);

        $sheet->getStyle('A1:H1')->applyFromArray($headingStyle);
        $sheet->getStyle('A2:H2')->getAlignment()
            ->setHorizontal(\PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER)
            ->setVertical(\PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER);
        $sheet->getStyle('A3:H4')->applyFromArray($headingStyle);

        $sheet->getStyle('A1:H'.$lastRow)->applyFromArray($borderStyle);

        $sheet->getHeaderFooter()->setOddFooter($this->footer);

    }
}
