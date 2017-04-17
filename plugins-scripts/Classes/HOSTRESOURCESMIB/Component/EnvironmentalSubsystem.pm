package Classes::HOSTRESOURCESMIB::Component::EnvironmentalSubsystem;
our @ISA = qw(Monitoring::GLPlugin::SNMP::Item);
use strict;

sub init {
  my $self = shift;
  $self->{disk_subsystem} =
      Classes::HOSTRESOURCESMIB::Component::DiskSubsystem->new();
  $self->{printer_subsystem} =
      Classes::HOSTRESOURCESMIB::Component::PrinterSubsystem->new();
}

sub check {
  my $self = shift;
  $self->{disk_subsystem}->check();
  $self->{printer_subsystem}->check();
  $self->reduce_messages_short('environmental hardware working fine');
}

sub dump {
  my $self = shift;
  $self->{disk_subsystem}->dump();
  $self->{printer_subsystem}->dump();
}

