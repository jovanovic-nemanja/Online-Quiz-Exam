<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>{{ $quiz['title'] }} Quiz Score Report</title>
        <style>
            body { width: 100%; color: #444; font-family: "Helvetica Neue", Helvetica, Arial, sans-serif}
            table {width: 100%;border: 1px solid transparent}
            table {border-collapse: collapse}
            table, th {border: 1px solid transparent;vertical-align: middle;padding: 5px}
            td {border: 1px solid transparent;padding: 5px}
            footer {position: fixed;bottom: 0;left: 0;right: 0;height: 20px}
            .footer-note {padding-top: 10px; font-size: 12px}
            .logo-block {text-align: center; width: 30%}
            .heading-block {text-align: right; width: 70%}
            .logo {height: 35px}
            .heading {text-align: center; background: #dadada;font-weight: bold}
            .list-item {display: block;padding: 4px}
            .heading-item {display: block;padding: 4px;margin-top: 4px}
            .text-center {text-align: center}
            .uppercase {text-transform: uppercase}
            .signature-block {text-align: center; vertical-align: bottom}
            .green {color: green}
            .red {color: red}
            .w-25 {width: 25%}
            .w-50 {width: 50%}
        </style>
    </head>
    <body>
    <div class="report">
        <table>
            <thead>
            <tr>
                <th colspan="1" class="logo-block">
                    <img class="logo" src="{{ $logo }}" alt="Logo" />
                </th>
                <th colspan="3" class="heading-block">
                    <h2>Quiz Score Report</h2>
                    <h3>{{ $quiz['title'] }}</h3>
                </th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td colspan="2" class="heading w-50">
                    Test Details
                </td>
                <td colspan="2" class="heading w-50">
                    User Details
                </td>
            </tr>
            <tr>
                <td colspan="2" class="w-50">
                    <span class="heading-item"><strong>Quiz Name:</strong></span>
                    <span class="list-item">{{ $quiz['title'] }}</span>
                    <span class="heading-item"><strong>Completed on:</strong></span>
                    <span class="list-item">{{ $session['completed_at'] }}</span>
                    <span class="heading-item"><strong>Session ID:</strong></span>
                    <span class="list-item">{{ $session['id'] }}</span>
                    <br>
                </td>
                <td colspan="2" class="w-50">
                    <span class="heading-item"><strong>Test Taker:</strong></span>
                    <span class="list-item">{{ $session['user'] }}</span>
                    <span class="heading-item"><strong>E-Mail:</strong></span>
                    <span class="list-item">{{ $session['email'] }}</span>
                    <span class="heading-item"><strong>IP & Device:</strong></span>
                    <span class="list-item">{{ $session['ip'] }}, {{ $session['device'] }}, {{ $session['os'] }}, {{ $session['browser'] }}</span>
                    <br>
                </td>
            </tr>
            <tr>
                <td colspan="4" class="heading">
                    Test Results
                </td>
            </tr>
            @foreach($session['properties'] as $properties)
                <tr>
                    @foreach($properties as $property)
                        <td class="w-25">
                            <span class="list-item"><strong>{{ $property['key'] }}</strong></span>
                        </td>
                        <td class="w-25">
                            <span class="list-item">{{ $property['value'] }}</span>
                        </td>
                    @endforeach
                </tr>
            @endforeach
            <tr>
                <td colspan="2" class="w-50">
                    <br>
                    <h2 class="uppercase {{ $session['status'] == 'Passed' ? 'green' : 'red' }}">{{ $session['status'] }}</h2>
                    <br>
                    Final Result
                </td>
                <td colspan="2" class="signature-block w-50">Authorized by</td>
            </tr>
            </tbody>
        </table>
    </div>
    <footer>
        <p class="footer-note">{{ $footer }}</p>
    </footer>
    </body>
</html>

