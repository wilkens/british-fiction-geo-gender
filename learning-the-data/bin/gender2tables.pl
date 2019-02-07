#!/usr/bin/env perl

# gender2tables.pl - given a pre-configured csv file, save two new cvs files normalizing the first
# usage: ./bin/gender2tables.pl > ./etc/gender-genders.tsv

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Pubic License

# February 1, 2019 - first working version; goofy data structure


# configure
use constant FILE  => './etc/gender.csv';
use constant DATES => './etc/gender-dates.tsv';

# require
use strict;
use Text::CSV;

# initialize
my @genders        = ();
my @roles          = ();
my %dates          = ();
my $agent          = 0;
my $characters     = 0;
my $csv            = Text::CSV->new( { sep_char => ',' } );
my $file           = FILE;
my $i              = 0;
my $mod            = 0;
my $patient        = 0;
my $poss           = 0;
my $previousGender = '';
my $speaking       = 0;

# process each line from the data file
open DATA, " < $file" or die "Can't open $csv ($!)\n";
while ( <DATA> ) {
	
	# increment and skip the first line
	$i++;
	next if ( $i == 1 );

	# parse
	chop; 
	$csv->parse( $_ );
	my @fields = $csv->fields( );
	my $docid  = $fields[ 0 ];
	my $date   = $fields[ 1 ];
	my $gender = $fields[ 2 ];
	my $role   = $fields[ 3 ];
	my $count  = $fields[ 4 ];
	
	# update & re-initialize, conditionally
	if ( $gender ne $previousGender ) {
	
		# output; destined for the genders table
		if ( @roles ) { print( join( "\t", @roles ), "\n" ) }
				
		# re-initialize
		$previousGender = $gender;
		$characters = 0;
		$agent      = 0;
		$mod        = 0;
		$patient    = 0;
		$poss       = 0;
		$speaking   = 0;
	
	}
	
	# map roles
	if    ( $role eq 'characters' ) { $characters = $count }
	elsif ( $role eq 'agent' )      { $agent      = $count }
	elsif ( $role eq 'mod' )        { $mod        = $count }
	elsif ( $role eq 'patient' )    { $patient    = $count }
	elsif ( $role eq 'poss' )       { $poss       = $count }
	elsif ( $role eq 'speaking' )   { $speaking   = $count }
		
	# error
	else {

		# debug
		warn join( "\t", ( @fields ) ), "\n";
		warn "Unknown value for role ($role). Call Eric.\n";
		
	}

	# update the dates "table" and a row destined for the genders table
	$dates{ $docid } = $date;
	@roles           = ( $docid, $gender, $characters, $agent, $mod, $patient, $poss, $speaking );
	
}

# output dates
my $dates = DATES;
open( OUTPUT, " > $dates" ) or die "Can't open $dates ($!).\n";
for my $key ( sort( keys( %dates ) ) ) { print OUTPUT join( "\t", ( $key, $dates{ $key } ) ), "\n" }
close( OUTPUT );

# done
exit;