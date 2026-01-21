<?php
declare(strict_types=1);

/**
 * This File requires PHP >=7.0 to run
 *
 * @author Jan Pache <scrummer@gmx.ch>
 * @see https://www.php.net/manual/en/regexp.reference.performance.php
 */

// Change some of PHP's default configuration settings
@error_reporting(E_ALL);
@ini_set('memory_limit', '-1');
@ini_set('max_execution_time', '-1');

// Explicitly remove limit for PCRE
@ini_set('pcre.backtrack_limit', '-1');
@ini_set('pcre.recursion_limit', '-1');

$r1 = '';
$r2 = '';
$i = 0;

// Tested maximum that PHP is capable of: 31
const MAX_I = 26;

if (PHP_SAPI !== 'cli') {
    die('This is meant to be a console script only');
}

while ($i < MAX_I) {
    $i++;
    $r1 .= 'a?';
    $r2 .= 'a';
    $r = '/'.$r1.$r2.'/';
    $startTime = microtime(true);

    if (preg_match($r, $r2) !== false) {
        $runtime = microtime(true) - $startTime;
        echo sprintf('%1$s %2$s matches %3$s %4$s %5$f s%6$s', str_repeat(' ', MAX_I-$i), $r2, trim($r, '/'), str_repeat(' ', (MAX_I-$i)*3), $runtime, PHP_EOL);
    } else {
        echo 'matching failure'.PHP_EOL;
    }
}
