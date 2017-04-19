package Classes::Lexmark;
our @ISA = qw(Classes::Device);
use strict;

sub init {
  my $self = shift;
  $self->get_snmp_tables('PRINTER-MIB', [
    ['xxx', 'prtAlertTable', 'Monitoring::GLPlugin::SNMP::TableItem'],
  ]);
  $self->get_snmp_tables('LEXMARK-MPS-MIB', [
    ['yyy', 'deviceAlertTable', 'Monitoring::GLPlugin::SNMP::TableItem'],
  ]);
  $self->get_snmp_tables('LEXMARK-PVT-MIB', [
    ['zzz', 'prtgenAlertTable', 'Monitoring::GLPlugin::SNMP::TableItem'],
  ]);

  if ($self->mode =~ /device::hardware::health/) {
    $self->analyze_and_check_environmental_subsystem('Classes::Lexmark::Components::EnvironmentalSubsystem');
  } elsif ($self->mode =~ /device::consumables/) {
    $self->analyze_and_check_battery_subsystem('Classes::Lexmark::Components::ConsumablesSubsystem');
  } else {
    $self->no_such_mode();
  }
}

