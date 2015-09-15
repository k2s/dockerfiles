<?php
$s = "from php/postfix docker container: " . date(DATE_ATOM);
mail($argv[1], $s, $s);