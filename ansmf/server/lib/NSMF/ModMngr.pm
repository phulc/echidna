package NSMF::ModMngr;

use NSMF;
use NSMF::Common::Util;

use Data::Dumper;

use strict;
use v5.10;

sub load {
    my ($self, $module_name) = @_;

    my $module_path;
    my $nsmf    = NSMF->new;
    my $config  = $nsmf->config;
    my $modules = $config->{modules};
    
    if (lc $module_name ~~ @$modules) {
    
        $module_path = 'NSMF::Component::' . uc($module_name);
        eval "use $module_path";

        if($@) {
            die { status => 'error', message => "Failed to Load Module $module_name" };
        } else {
            return $module_path->new;
        }
    }

    die { status => 'error', message => 'Module Not Enabled' }; 
}

1;
