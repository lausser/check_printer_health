package CheckPrinterHealth::Device;
our @ISA = qw(Monitoring::GLPlugin::SNMP);
use strict;

sub classify {
  my $self = shift;
  if (! ($self->opts->hostname || $self->opts->snmpwalk)) {
    $self->add_unknown('either specify a hostname or a snmpwalk file');
  } else {
    $self->check_snmp_and_model();
    if (! $self->check_messages()) {
      if ($self->opts->verbose && $self->opts->verbose) {
        printf "I am a %s\n", $self->{productname};
      }
      if ($self->opts->mode =~ /^my-/) {
        $self->load_my_extension();
      } elsif ($self->implements_mib('LEXMARK-PVT-MIB')) {
        bless $self, 'CheckPrinterHealth::Lexmark';
        $self->debug('using CheckPrinterHealth::Lexmark');
      } elsif ($self->implements_mib('PRINTER-MIB')) {
        bless $self, 'CheckPrinterHealth::PRINTERMIB';
        $self->debug('using CheckPrinterHealth::PRINTERMIB');
      } elsif ($self->implements_mib('HOST-RESOURCES-MIB')) {
        bless $self, 'CheckPrinterHealth::HOSTRESOURCESMIB';
        $self->debug('using CheckPrinterHealth::HOSTRESOURCESMIB');
      } elsif ($self->implements_mib('KYOCERA-Private-MIB')) {
        bless $self, 'CheckPrinterHealth::Kyocera';
        $self->debug('using CheckPrinterHealth::Kyocera');
      } elsif ($self->implements_mib('BROTHER-MIB')) {
        bless $self, 'CheckPrinterHealth::Brother';
        $self->debug('using CheckPrinterHealth::Brother');
      } else {
        if (my $class = $self->discover_suitable_class()) {
          bless $self, $class;
          $self->debug('using '.$class);
        } else {
          bless $self, 'CheckPrinterHealth::Generic';
          $self->debug('using CheckPrinterHealth::Generic');
        }
      }
    }
  }
  return $self;
}


package CheckPrinterHealth::Generic;
our @ISA = qw(CheckPrinterHealth::Device);
use strict;

sub init {
  my $self = shift;
  if ($self->mode =~ /something specific/) {
  } else {
    bless $self, 'Monitoring::GLPlugin::SNMP';
    $self->no_such_mode();
  }
}
