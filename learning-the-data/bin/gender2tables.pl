#!/usr/bin/env perl

use constant CSV => './etc/gender.csv';

use strict;
use Text::CSV;

my $file    = CSV;
my %dates   = ();
my %genders = ();
my $characters;
my $agent;
my $mod;
my $patient;
my $poss;
my $speaking;
my $i = 0;

my $csv = Text::CSV->new( { sep_char => ',' } );

open DATA, " < $file" or die "Can't open $csv ($!)\n";
while ( <DATA> ) {
	
	$i++;
	next if ( $i == 1 );

	chop; 
	$csv->parse($_);
	my @fields =  $csv->fields( );
	my $docid  =  $fields[ 0 ];
	   $docid  =~ s/"//g;
	my $date   =  $fields[ 1 ];
	my $gender =  $fields[ 2 ];
	my $role   =  $fields[ 3 ];
	my $count  =  $fields[ 4 ];
	
	if    ( $role eq 'characters' ) { $characters = $count }
	elsif ( $role eq 'agent' )      { $agent      = $count }
	elsif ( $role eq 'mod' )        { $mod        = $count }
	elsif ( $role eq 'patient' )    { $patient    = $count }
	elsif ( $role eq 'poss' )       { $poss       = $count }
	elsif ( $role eq 'speaking' )   { $speaking   = $count }
	else {

		warn join( "\t", ( @fields ) ), "\n";
		warn "Unknown value for role ($role). Call Eric.\n";
		
	}
		
	$dates{ $docid } = $date;
	
}

for my $key ( sort( keys( %dates ) ) ) { print join( "\t", ( $key, $dates{ $key } ), "\n" ) }

exit;