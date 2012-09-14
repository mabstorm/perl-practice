#!/usr/bin/perl

use strict;
use DBI;

my $db = DBI->connect("dbi:mysql:training_db:localhost", "root", "",
{AutoCommit=>0} );
my $dbh1 = $db->prepare( <<"SQL" );
        UPDATE instructor_tst
        SET last_name = 'DeadLock2'
        WHERE instructor_id = 'KDC007'
SQL

$dbh1->execute();
$dbh1->finish();
$db->commit();

print "hit Enter.";
my $enter = <STDIN>;

my $dbh2 = $db->prepare( <<"SQL" );
        UPDATE instructor_tst
        SET last_name = 'DeadLock2'
        WHERE instructor_id = 'KDC001'
SQL

$dbh2->execute();
$dbh2->finish();

$db->commit();
$db->disconnect();
