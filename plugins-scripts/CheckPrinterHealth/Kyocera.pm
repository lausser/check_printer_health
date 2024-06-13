package CheckPrinterHealth::Kyocera;
our @ISA = qw(CheckPrinterHealth::Device);
use strict;

sub init {
  my $self = shift;
  $self->get_snmp_tables('KYOCERA-Private-MIB', [
    ['xxx', 'kcprtMemoryDeviceTable', 'Monitoring::GLPlugin::SNMP::TableItem'],
#https://pastebin.com/ZvuFXPcU
  ]);

  if ($self->mode =~ /device::hardware::health/) {
    $self->analyze_and_check_environmental_subsystem('CheckPrinterHealth::HOSTRESOURCESMIB::Component::EnvironmentalSubsystem');
  } elsif ($self->mode =~ /device::consumables/) {
    $self->analyze_and_check_environmental_subsystem('CheckPrinterHealth::HOSTRESOURCESMIB::Component::EnvironmentalSubsystem');
    $self->analyze_and_check_battery_subsystem('CheckPrinterHealth::Kyocera::Components::BatterySubsystem');
  } else {
    $self->no_such_mode();
  }
}

