package Classes::Kyocera;
our @ISA = qw(Classes::Device);
use strict;

sub init {
  my $self = shift;
  $self->get_snmp_tables('KYOCERA-Private-MIB', [
    ['xxx', 'kcprtMemoryDeviceTable', 'Monitoring::GLPlugin::SNMP::TableItem'],
#https://pastebin.com/ZvuFXPcU
  ]);

  if ($self->mode =~ /device::hardware::health/) {
    $self->analyze_and_check_environmental_subsystem('Classes::HOSTRESOURCESMIB::Component::EnvironmentalSubsystem');
    $self->clear_ok();
    #$self->analyze_and_check_environmental_subsystem('Classes::XUPS::Components::EnvironmentalSubsystem');
  } elsif ($self->mode =~ /device::battery/) {
    $self->analyze_and_check_battery_subsystem('Classes::Kyocera::Components::BatterySubsystem');
  } else {
    $self->no_such_mode();
  }
}

