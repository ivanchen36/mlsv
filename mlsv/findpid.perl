
$progname = $ARGV[0];

$p = `ps auxw|grep $progname|grep -v grep|grep -v gdb`;



@ll = split( /\n/ , $p );

$hoge = "";

foreach $l ( @ll ){
	if( $l =~ /$progname/ ){
		($user,$pid)=split(/\s+/ , $l );
		next if( $pid == $$ );
		last;
	}
}


print $pid;
