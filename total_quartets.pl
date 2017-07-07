#use strict;
use warnings;
use Getopt::Long;
#author: Allison Doherty

my $infile = $ARGV[0];
my $outfile = $ARGV[1];

#creates an array of every line of the file
my @lines;
open (my $fh, '<:encoding(UTF-8)', $infile) or die "Could not open file '$infile' $!";
while (my $line = <$fh>){
	chomp $line;
	my ($quart, $extra) = split(/\./,$line);
	push @lines, $quart;
}
close $fh;
	
open (my $in, '<:encoding(UTF-8)', $infile) or die "Could not open file '$infile' $!";
open (my $out, '>', $outfile) or die "Could not open file '$outfile' $!";
#goes through every line of the file
my $firstnum;
my $secondnum;
my $thirdnum;
my $fourthnum;
while (my $line = <$in>){
	chomp $line;
	#searches for the four numbers
	my $nth;
	my $nth2;
	my $counter = 0;
	my $linelength = length $line;
	for (my $i=0; $i < $linelength; $i++){
		$nth = substr($line, $i, 1);
		if (($nth eq '1') || ($nth eq '2') || ($nth eq '3') || ($nth eq '4') || ($nth eq '5') ||
			($nth eq '6') || ($nth eq '7') || ($nth eq '8') || ($nth eq '9') || ($nth eq '0')){
			$firstnum = $nth;
			#checks to see what the next number is 
			$nth2 = substr($line, $i+1, 1);
			if (($nth2 eq '1') || ($nth2 eq '2') || ($nth2 eq '3') || ($nth2 eq '4') || ($nth2 eq '5') ||
			($nth2 eq '6') || ($nth2 eq '7') || ($nth2 eq '8') || ($nth2 eq '9') || ($nth2 eq '0')){
				$firstnum .= $nth2;
			}
			$i++;
			$counter++;
			last;
		}
		$counter++;
	}
	$counter++;
	#searches for the second number
	for (my $i=$counter; $i < $linelength; $i++){
		$nth = substr($line, $i, 1);
		if (($nth eq '1') || ($nth eq '2') || ($nth eq '3') || ($nth eq '4') || ($nth eq '5') ||
			($nth eq '6') || ($nth eq '7') || ($nth eq '8') || ($nth eq '9') || ($nth eq '0')){
			$secondnum = $nth;
			#checks to see what the next number is 
			$nth2 = substr($line, $i+1, 1);
			if (($nth2 eq '1') || ($nth2 eq '2') || ($nth2 eq '3') || ($nth2 eq '4') || ($nth2 eq '5') ||
			($nth2 eq '6') || ($nth2 eq '7') || ($nth2 eq '8') || ($nth2 eq '9') || ($nth2 eq '0')){
				$secondnum .= $nth2;
			}
			$i++;
			$counter++;
			last;
		}
		$counter++;
	}
	$counter++;
	#searches for the third number
	for (my $i=$counter; $i < $linelength; $i++){
		$nth = substr($line, $i, 1);
		if (($nth eq '1') || ($nth eq '2') || ($nth eq '3') || ($nth eq '4') || ($nth eq '5') ||
			($nth eq '6') || ($nth eq '7') || ($nth eq '8') || ($nth eq '9') || ($nth eq '0')){
			$thirdnum = $nth;
			#checks to see what the next number is 
			$nth2 = substr($line, $i+1, 1);
			if (($nth2 eq '1') || ($nth2 eq '2') || ($nth2 eq '3') || ($nth2 eq '4') || ($nth2 eq '5') ||
			($nth2 eq '6') || ($nth2 eq '7') || ($nth2 eq '8') || ($nth2 eq '9') || ($nth2 eq '0')){
				$thirdnum .= $nth2;
			}
			$i++;
			$counter++;
			last;
		}
		$counter++;
	}
	$counter++;
	#searches for the fourth number
	for (my $i=$counter; $i < $linelength; $i++){
		$nth = substr($line, $i, 1);
		if (($nth eq '1') || ($nth eq '2') || ($nth eq '3') || ($nth eq '4') || ($nth eq '5') ||
			($nth eq '6') || ($nth eq '7') || ($nth eq '8') || ($nth eq '9') || ($nth eq '0')){
			$fourthnum = $nth;
			#checks to see what the next number is 
			$nth2 = substr($line, $i+1, 1);
			if (($nth2 eq '1') || ($nth2 eq '2') || ($nth2 eq '3') || ($nth2 eq '4') || ($nth2 eq '5') ||
			($nth2 eq '6') || ($nth2 eq '7') || ($nth2 eq '8') || ($nth2 eq '9') || ($nth2 eq '0')){
				$fourthnum .= $nth2;
			}
			$i++;
			$counter++;
			last;
		}
		$counter++;
	}
	#determines the second quartet format we're looking for
	my @secondnumber = split("", $secondnum);
	my @thirdnumber = split("", $thirdnum);
	my @fourthnumber = split("", $fourthnum);
	my $secondquartet = "$firstnum,$thirdnum|";
	if ($secondnumber[0] < $fourthnumber[0]){
		$secondquartet .= "$secondnum,$fourthnum";
	}
	elsif ($secondnumber[0] > $fourthnumber[0]){
		$secondquartet .= "$fourthnum,$secondnum";
	}
	else{
		#sees if one of the numbers has only one digit
		my $secondl = @secondnumber;
		my $fourthl = @fourthnumber;
		if ($secondl eq '1'){
			$secondquartet .= "$secondnum,$fourthnum";
		}
		elsif ($fourthl eq '1'){
			$secondquartet .= "$fourthnum,$secondnum";
		}
		else{
			#the numbers both have two digits, so compare the second digit of both
			if ($secondnumber[1] < $fourthnumber[1]){
				$secondquartet .= "$secondnum,$fourthnum";
			}
			else{
				$secondquartet .= "$fourthnum,$secondnum";
			}
		}
	}
	#determines the third quartet format we're looking for
	my $thirdquartet = "$firstnum,$fourthnum|";
	if ($secondnumber[0] < $thirdnumber[0]){
		$thirdquartet .= "$secondnum,$thirdnum";
	}
	elsif ($secondnumber[0] > $thirdnumber[0]){
		$thirdquartet .= "$thirdnum,$secondnum";
	}
	else{
		#sees if one of the numbers has only one digit
		my $secondl = @secondnumber;
		my $thirdl = @thirdnumber;
		if ($secondl eq '1'){
			$thirdquartet .= "$secondnum,$thirdnum";
		}
		elsif ($thirdl eq '1'){
			$thirdquartet .= "$thirdnum,$secondnum";
		}
		else{
			#the numbers both have two digits, so compare the second digit of both
			if ($secondnumber[1] < $thirdnumber[1]){
				$thirdquartet .= "$secondnum,$thirdnum";
			}
			else{
				$thirdquartet .= "$thirdnum,$secondnum";
			}
		}
	}

	#does a binary search to see where the second quartet is 
	my $high = @lines;
	my $low = 0;
	my $found_key = 0;
	my $mid;
	my $secondtotal = 0;
	#splits the quartet being compared into its four parts
	my @origquartetsplit = split(/\|/,$secondquartet);
	my @origfirstsecond = split(/\,/,$origquartetsplit[0]);
	my @origthirdfourth = split(/\,/,$origquartetsplit[1]);
	my @firstquartetarray = ("","");
	my $quartet1 = 0;
	my $value1 = 0;
	my @quartet1split = ("","");
	my @listfirstsecond = ("","");
	my @listthirdfourth = ("","");
	while (($low <= $high) && !$found_key){
		$mid = int(($low + $high) / 2);
		#gets the right format
		@firstquartetarray = split(/\:/,$lines[$mid]);
		$quartet1 = $firstquartetarray[0];
		$value1 = $firstquartetarray[1];
		#splits the quartet1 into four values (listfirstnum - listfourthnum)
		#and the secondquartet into four values
		@quartet1split = split(/\|/,$quartet1);
		#splits that into the four sections
		@listfirstsecond = split(/\,/,$quartet1split[0]);
		@listthirdfourth = split(/\,/,$quartet1split[1]);
		#if it finds the quartet in the array of quartets 
		if (($listfirstsecond[0] == $origfirstsecond[0])&&($listfirstsecond[1] == $origfirstsecond[1])&&
			($listthirdfourth[0] == $origthirdfourth[0])&&($listthirdfourth[1] == $origthirdfourth[1])){
			$found_key = 1;
			$secondtotal = $value1;
		}
		#sees if the quartet is less than or greater than the one we're looking for
		elsif ($origfirstsecond[0] lt $listfirstsecond[0]){
			$high = $mid-1;
		}
		elsif ($listfirstsecond[0] lt $origfirstsecond[0]){
			$low = $mid+1;
		}
		elsif ($origfirstsecond[1] lt $listfirstsecond[1]){
			$high = $mid-1;
		}
		elsif ($listfirstsecond[1] lt $origfirstsecond[1]){
			$low = $mid+1;
		}
		elsif ($origthirdfourth[0] lt $listthirdfourth[0]){
			$high = $mid-1;
		}
		elsif ($listthirdfourth[0] lt $origthirdfourth[0]){
			$low = $mid+1;
		}
		elsif ($origthirdfourth[1] lt $listthirdfourth[1]){
			$high = $mid-1;
		}
		else{
			$low = $mid+1;
		}
	}

	#does a binary search to see where the third quartet is
	$high = @lines;
	$low = 0;
	$found_key = 0;
	my $thirdtotal = 0;
	#splits the quartet being compared into its four parts
	my @orig2quartetsplit = split(/\|/,$thirdquartet);
	my @orig2firstsecond = split(/\,/,$orig2quartetsplit[0]);
	my @orig2thirdfourth = split(/\,/,$orig2quartetsplit[1]);
	my @secondquartetarray = ("","");
	my $quartet2 = 0;
	my $value2 = 0;
	my @quartet2split = ("","");
	my @list2firstsecond = ("","");
	my @list2thirdfourth = ("","");
	while (($low <= $high) && !$found_key){
		$mid = int(($low + $high) / 2);
		#gets the right format
		@secondquartetarray = split(/\:/,$lines[$mid-1]);
		$quartet2 = $secondquartetarray[0];
		$value2 = $secondquartetarray[1];
		#splits the quartet1 into four values (listfirstnum - listfourthnum)
		#and the secondquartet into four values
		@quartet2split = split(/\|/,$quartet2);
		#splits that into the four sections
		@list2firstsecond = split(/\,/,$quartet2split[0]);
		@list2thirdfourth = split(/\,/,$quartet2split[1]);
		#if we found the quartet we're looking for
		if (($list2firstsecond[0] == $orig2firstsecond[0])&&($list2firstsecond[1] == $orig2firstsecond[1])&&
			($list2thirdfourth[0] == $orig2thirdfourth[0])&&($list2thirdfourth[1] == $orig2thirdfourth[1])){
			$found_key = 1;
			$thirdtotal = $value2;
		}
		#sees if the quartet is less than or greater than the one we're looking for
		elsif ($orig2firstsecond[0] lt $list2firstsecond[0]){
			$high = $mid-1;
		}
		elsif ($list2firstsecond[0] lt $orig2firstsecond[0]){
			$low = $mid+1;
		}
		elsif ($orig2firstsecond[1] lt $list2firstsecond[1]){
			$high = $mid-1;
		}
		elsif ($list2firstsecond[1] lt $orig2firstsecond[1]){
			$low = $mid+1;
		}
		elsif ($orig2thirdfourth[0] lt $list2thirdfourth[0]){
			$high = $mid-1;
		}
		elsif ($list2thirdfourth[0] lt $orig2thirdfourth[0]){
			$low = $mid+1;
		}
		elsif ($orig2thirdfourth[1] lt $list2thirdfourth[1]){
			$high = $mid-1;
		}
		else{
			$low = $mid+1;
		}
	}

	#adds the three totals together
	my ($quartet3, $firsttotal) = split(/\:/,$line);
	my $total = $firsttotal + $secondtotal + $thirdtotal;
	print $out "$line:$total\n";

}
close $in;
close $out;
