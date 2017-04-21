package Classes::Lexmark;
our @ISA = qw(Classes::Device);
use strict;

sub init {
  my $self = shift;
  if ($self->mode =~ /device::hardware::health/) {
    #$self->analyze_and_check_environmental_subsystem('Classes::PRINTERMIB::Component::PrinterSubsystem');
    $self->analyze_and_check_battery_subsystem('Classes::Lexmark::Component::PrinterSubsystem');
  } elsif ($self->mode =~ /device::printer::consumables/) {
    #$self->analyze_and_check_battery_subsystem('Classes::Lexmark::Components::ConsumablesSubsystem');
    $self->analyze_and_check_battery_subsystem('Classes::Lexmark::Component::PrinterSubsystem');
  } else {
    $self->no_such_mode();
  }
}

