package CheckPrinterHealth::Lexmark;
our @ISA = qw(CheckPrinterHealth::Device);
use strict;

sub init {
  my $self = shift;
  if ($self->mode =~ /device::hardware::health/) {
    $self->analyze_and_check_lxprinter_subsystem('CheckPrinterHealth::Lexmark::Component::PrinterSubsystem');
    if (! $self->check_errors()) {
      # ...kontrolle ist besser.
      $self->analyze_and_check_printer_subsystem('CheckPrinterHealth::PRINTERMIB::Component::PrinterSubsystem');
    }
    $self->reduce_messages_short('hardware working fine');
  } elsif ($self->mode =~ /device::printer::consumables/) {
    $self->analyze_and_check_consumables_subsystem('CheckPrinterHealth::Lexmark::Component::ConsumablesSubsystem');
    $self->analyze_and_check_consumables_subsystem('CheckPrinterHealth::PRINTERMIB::Component::PrinterSubsystem');
    $self->reduce_messages_short('supplies status is fine');
  } else {
    $self->no_such_mode();
  }
}

