package App::TemplateServer::Provider::Mason;
use Moose;
use Method::Signatures;
use File::Find;
use HTML::Mason::Interp;
use Path::Class qw(file);

with 'App::TemplateServer::Provider';

method list_templates {
    my $docroot = $self->docroot;
    
    my @files;
    find(sub { 
             my $name = $File::Find::name;
             push @files, File::Spec->abs2rel($name, $docroot) 
               if -f $name;
         },
         $docroot);
    
    return @files;
};

method render_template($template, $context){
    my $outbuf;
    
    my %data = %{$context->data||{}};
    my @globals = map { "\$$_" } keys %data;

    my $interp = HTML::Mason::Interp->new(
        comp_root     => q{}.$self->docroot,
        out_method    => \$outbuf,
        allow_globals => \@globals
          
    );
    
    # set globals
    for my $var (keys %data){
        my $val  = $data{$var};
        $interp->set_global($var, $val);
        warn qq{adding "$var => $val"};
    }
    
    $interp->exec("/$template");
    return $outbuf;
};

1;

__END__

=head1 NAME

App::TemplateServer::Provider::Mason - serve Mason templates with App::TemplateServer

