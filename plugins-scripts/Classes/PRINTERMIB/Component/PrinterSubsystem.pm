package Classes::PRINTERMIB::Component::PrinterSubsystem;
our @ISA = qw(Monitoring::GLPlugin::SNMP::Item);
use strict;

sub init {
  my $self = shift;
  $self->get_snmp_tables('PRINTER-MIB', [
      ['covers', 'prtCoverTable', 'Classes::PRINTERMIB::Component::PrinterSubsystem::Cover'],
      ['inputs', 'prtInputTable', 'Classes::PRINTERMIB::Component::PrinterSubsystem::Input'],
      ['outputs', 'prtOutputTable', 'Classes::PRINTERMIB::Component::PrinterSubsystem::Output'],
      ['markers', 'prtMarkerTable', 'Classes::PRINTERMIB::Component::PrinterSubsystem::Marker'],
      ['media', 'prtMediaPathTable', 'Classes::PRINTERMIB::Component::PrinterSubsystem::MediaPath'],
      ['channels', 'prtChannelTable', 'Classes::PRINTERMIB::Component::PrinterSubsystem::Channel'],
  ]);
}

package Classes::PRINTERMIB::Component::PrinterSubsystem::Cover;
our @ISA = qw(Monitoring::GLPlugin::SNMP::TableItem);
use strict;

package Classes::PRINTERMIB::Component::PrinterSubsystem::Input;
our @ISA = qw(Monitoring::GLPlugin::SNMP::TableItem);
use strict;

package Classes::PRINTERMIB::Component::PrinterSubsystem::Output;
our @ISA = qw(Monitoring::GLPlugin::SNMP::TableItem);
use strict;

package Classes::PRINTERMIB::Component::PrinterSubsystem::Marker;
our @ISA = qw(Monitoring::GLPlugin::SNMP::TableItem);
use strict;

package Classes::PRINTERMIB::Component::PrinterSubsystem::MediaPath;
our @ISA = qw(Monitoring::GLPlugin::SNMP::TableItem);
use strict;

package Classes::PRINTERMIB::Component::PrinterSubsystem::Channel;
our @ISA = qw(Monitoring::GLPlugin::SNMP::TableItem);
use strict;

__END__


PRINTER-MIB::prtInputStatus
PRINTER-MIB::prtOutputStatus

