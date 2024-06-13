package CheckPrinterHealth::Brother;
our @ISA = qw(CheckPrinterHealth::Device);
use strict;

sub init {
  my $self = shift;
  if ($self->mode =~ /device::hardware::health/) {
    $self->analyze_and_check_environmental_subsystem('CheckPrinterHealth::HOSTRESOURCESMIB::Component::EnvironmentalSubsystem');
  } elsif ($self->mode =~ /device::battery/) {
    $self->analyze_and_check_battery_subsystem('CheckPrinterHealth::Kyocera::Components::BatterySubsystem');
  } else {
    $self->no_such_mode();
  }
}

