package Classes::PRINTERMIB::Component::PrinterSubsystem;
our @ISA = qw(Monitoring::GLPlugin::SNMP::Item);
use strict;

sub init {
  my ($self) = @_;
  if ($self->mode =~ /device::hardware::health/) {
    $self->get_snmp_tables('PRINTER-MIB', [
        ['covers', 'prtCoverTable', 'Classes::PRINTERMIB::Component::PrinterSubsystem::Cover'],
        ['channels', 'prtChannelTable', 'Classes::PRINTERMIB::Component::PrinterSubsystem::Channel'],
    ]);
  } elsif ($self->mode =~ /device::printer::consumables/) {
    $self->get_snmp_tables('PRINTER-MIB', [
        ['inputs', 'prtInputTable', 'Classes::PRINTERMIB::Component::PrinterSubsystem::Input'],
        ['outputs', 'prtOutputTable', 'Classes::PRINTERMIB::Component::PrinterSubsystem::Output'],
        ['supplies', 'prtMarkerSuppliesTable', 'Classes::PRINTERMIB::Component::PrinterSubsystem::MarkerSupply'],
        ['markers', 'prtMarkerTable', 'Classes::PRINTERMIB::Component::PrinterSubsystem::Marker'],
        ['media', 'prtMediaPathTable', 'Classes::PRINTERMIB::Component::PrinterSubsystem::MediaPath'],
    ]);
  }
}

package Classes::PRINTERMIB::Component::PrinterSubsystem::Cover;
our @ISA = qw(Monitoring::GLPlugin::SNMP::TableItem);
use strict;

sub check {
  my ($self) = @_;
  $self->add_info(sprintf '%s is %s',
      $self->{prtCoverDescription},
      $self->{prtCoverStatus}
  );
  if ($self->{prtCoverStatus} =~ /Open/) {
    $self->add_critical();
  }
}

package Classes::PRINTERMIB::Component::PrinterSubsystem::Input;
our @ISA = qw(Monitoring::GLPlugin::SNMP::TableItem);
use strict;

package Classes::PRINTERMIB::Component::PrinterSubsystem::Output;
our @ISA = qw(Monitoring::GLPlugin::SNMP::TableItem);
use strict;

package Classes::PRINTERMIB::Component::PrinterSubsystem::Marker;
our @ISA = qw(Monitoring::GLPlugin::SNMP::TableItem);
use strict;

package Classes::PRINTERMIB::Component::PrinterSubsystem::MarkerSupply;
our @ISA = qw(Monitoring::GLPlugin::SNMP::TableItem);
use strict;

sub finish {
  my ($self) = @_;
  if ($self->{prtMarkerSuppliesDescription} =~ /^[^ ]{2} [^ ]{2} [^ ]{2}/) {
    $self->{prtMarkerSuppliesDescription} =
        $self->unhex_octet_string($self->{prtMarkerSuppliesDescription});
    # wird ueblicherweise gehext, wenn da umlautschlonz drin ist
    $self->{prtMarkerSuppliesDescription} =~ s/[[:^ascii:]]//g;
  } elsif (! $self->{prtMarkerSuppliesDescription}) {
    # Kyocera ECOSYS P2135dn, prtMarkerSuppliesDescription is empty
    $self->{prtMarkerSuppliesDescription} = $self->{prtMarkerSuppliesType};
  }
}

sub check {
  my ($self) = @_;
  if ($self->{prtMarkerSuppliesClass} eq 'supplyThatIsConsumed') {
    $self->{usage} = 100 * $self->{prtMarkerSuppliesLevel} /
        $self->{prtMarkerSuppliesMaxCapacity};
    $self->add_info(sprintf '%s is at %.2f%%',
        $self->{prtMarkerSuppliesDescription}, $self->{usage}
    );
    my $label = $self->{prtMarkerSuppliesDescription}.'_remaining';
    $label =~ s/\s+/_/g;
    $label =~ s/://g;
    $self->set_thresholds(
        metric => $label, warning => '20:', critical => '5:',
    );
    if ($self->{prtMarkerSuppliesLevel} == -1) {
      $self->add_message_ok($self->check_thresholds(
          metric => $label, value => $self->{usage},
      ));
    } elsif ($self->{prtMarkerSuppliesLevel} == -2) {
      # The value (-2) means unknown
      $self->add_unknown(sprintf 'status of %s is unknown',
          $self->{prtMarkerSuppliesDescription});
    } elsif ($self->{prtMarkerSuppliesLevel} == -3) {
      # A value of (-3) means that the
      # printer knows that there is some supply/remaining space
      $self->add_message_ok();
      $self->set_thresholds(
          metric => $label, warning => '', critical => '',
      );
      $self->add_perfdata(
          label => $label, value => 0, uom => '%',
      );
    } else {
      $self->add_message($self->check_thresholds(
          metric => $label, value => $self->{usage},
      ));
      $self->add_perfdata(
          label => $label, value => $self->{usage}, uom => '%',
      );
    }
  } elsif ($self->{prtMarkerSuppliesClass} eq 'receptacleThatIsFilled') {

  }
}

package Classes::PRINTERMIB::Component::PrinterSubsystem::MediaPath;
our @ISA = qw(Monitoring::GLPlugin::SNMP::TableItem);
use strict;

package Classes::PRINTERMIB::Component::PrinterSubsystem::Channel;
our @ISA = qw(Monitoring::GLPlugin::SNMP::TableItem);
use strict;

__END__


PRINTER-MIB::prtInputStatus
PRINTER-MIB::prtOutputStatus

