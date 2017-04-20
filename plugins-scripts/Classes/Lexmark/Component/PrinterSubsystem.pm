package Classes::Lexmark::Component::PrinterSubsystem;;
our @ISA = qw(Monitoring::GLPlugin::SNMP::Item);
use strict;

sub init {
  my $self = shift;
  my $tables = <<EOEO;
HOST-RESOURCES-MIB::hrStorageTable
HOST-RESOURCES-MIB::hrDeviceTable
HOST-RESOURCES-MIB::hrProcessorTable
HOST-RESOURCES-MIB::hrNetworkTable
HOST-RESOURCES-MIB::hrPrinterTable
HOST-RESOURCES-MIB::hrDiskStorageTable
HOST-RESOURCES-MIB::hrPartitionTable
HOST-RESOURCES-MIB::hrFSTable
PRINTER-MIB::prtGeneralTable
PRINTER-MIB::prtStorageRefTable
PRINTER-MIB::prtDeviceRefTable
PRINTER-MIB::prtCoverTable
PRINTER-MIB::prtLocalizationTable
PRINTER-MIB::prtInputTable
PRINTER-MIB::prtOutputTable
PRINTER-MIB::prtMarkerTable
PRINTER-MIB::prtMarkerSuppliesTable
PRINTER-MIB::prtMarkerColorantTable
PRINTER-MIB::prtMediaPathTable
PRINTER-MIB::prtChannelTable
PRINTER-MIB::prtInterpreterTable
PRINTER-MIB::prtConsoleDisplayBufferTable
PRINTER-MIB::prtConsoleLightTable
PRINTER-MIB::prtAlertTable
LEXMARK-PVT-MIB::opsysCurrentJobTable
LEXMARK-PVT-MIB::lextcpNPAPserversTable
LEXMARK-PVT-MIB::lextrapDestTable
LEXMARK-PVT-MIB::prtgenInfoTable
LEXMARK-PVT-MIB::prtgenStatusTable
LEXMARK-MPS-MIB::deviceTable
LEXMARK-MPS-MIB::hwInventoryTable
LEXMARK-MPS-MIB::supplyInventoryTable
LEXMARK-MPS-MIB::swInventoryTable
LEXMARK-MPS-MIB::genCountTable
LEXMARK-MPS-MIB::paperGeneralCountTable
LEXMARK-MPS-MIB::paperSidesCountTable
LEXMARK-MPS-MIB::paperSheetsCountTable
LEXMARK-MPS-MIB::paperNupCountTable
LEXMARK-MPS-MIB::paperJobSizeTable
LEXMARK-MPS-MIB::scanCountTable
LEXMARK-MPS-MIB::currentSuppliesTable
LEXMARK-MPS-MIB::supplyHistoryTable
LEXMARK-MPS-MIB::supplyHistogramTable
LEXMARK-MPS-MIB::deviceAlertTable
EOEO
  my %tables = ();
  foreach my $table (split(/\n/, $tables)) {
    chomp $table;
    $table =~ /(.*)::(.*)/;
    if (! exists $tables{$1}) {
      $tables{$1} = [];
    }
    push(@{$tables{$1}}, [$2.'s', $2, 'Monitoring::GLPlugin::SNMP::TableItem']);
  }
  foreach my $mib (keys %tables) {
    $self->get_snmp_tables($mib, $tables{$mib});
  }
}


__END__
Kat 1 Papier, input tray
Kat 2 Toner

HOST-RESOURCES-MIB::hrPrinterTable
HOST-RESOURCES-MIB::hrPrinterStatus.1 = idle
HOST-RESOURCES-MIB::hrPrinterDetectedErrorState.1 = noPaper|serviceRequested

PRINTER-MIB::prtAlertCriticalEvents.1 = 0
PRINTER-MIB::prtAlertAllEvents.1 = 2

PRINTER-MIB::prtCoverTable
PRINTER-MIB::prtCoverDescription.1.1 = Klappe A
PRINTER-MIB::prtCoverDescription.1.2 = Klappe B
PRINTER-MIB::prtCoverDescription.1.3 = Klappe C
PRINTER-MIB::prtCoverDescription.1.4 = Klappe D
PRINTER-MIB::prtCoverDescription.1.5 = Klappe E
PRINTER-MIB::prtCoverDescription.1.6 = Abdeckung J
PRINTER-MIB::prtCoverStatus.1.1 = coverClosed
PRINTER-MIB::prtCoverStatus.1.2 = coverClosed
PRINTER-MIB::prtCoverStatus.1.3 = coverClosed
PRINTER-MIB::prtCoverStatus.1.4 = coverClosed
PRINTER-MIB::prtCoverStatus.1.5 = coverClosed
PRINTER-MIB::prtCoverStatus.1.6 = coverClosed

PRINTER-MIB::prtInputStatus.1.1 = 17
PRINTER-MIB::prtInputStatus.1.2 = 4
PRINTER-MIB::prtInputStatus.1.3 = 4
PRINTER-MIB::prtInputStatus.1.4 = 17
PRINTER-MIB::prtInputStatus.1.5 = 4
PRINTER-MIB::prtInputStatus.1.6 = 4
PRINTER-MIB::prtInputStatus.1.7 = 4



PRINTER-MIB::prtOutputStatus.1.1 = 4
PRINTER-MIB::prtOutputStatus.1.2 = 4

PRINTER-MIB::prtMarkerStatus.1.1 = 4

PRINTER-MIB::prtMarkerSuppliesTable

PRINTER-MIB::prtMarkerSuppliesSupplyUnit.1.10 = impressions
PRINTER-MIB::prtMarkerSuppliesSupplyUnit.1.11 = impressions
PRINTER-MIB::prtMarkerSuppliesSupplyUnit.1.12 = impressions
PRINTER-MIB::prtMarkerSuppliesSupplyUnit.1.13 = impressions
PRINTER-MIB::prtMarkerSuppliesMaxCapacity.1.1 = 22000
PRINTER-MIB::prtMarkerSuppliesMaxCapacity.1.2 = 22000
PRINTER-MIB::prtMarkerSuppliesMaxCapacity.1.3 = 22000
PRINTER-MIB::prtMarkerSuppliesMaxCapacity.1.4 = 32000
PRINTER-MIB::prtMarkerSuppliesMaxCapacity.1.5 = 22000
PRINTER-MIB::prtMarkerSuppliesMaxCapacity.1.6 = 22000
PRINTER-MIB::prtMarkerSuppliesMaxCapacity.1.7 = 22000
PRINTER-MIB::prtMarkerSuppliesMaxCapacity.1.8 = 22000
PRINTER-MIB::prtMarkerSuppliesMaxCapacity.1.9 = 20000
PRINTER-MIB::prtMarkerSuppliesMaxCapacity.1.10 = 160000
PRINTER-MIB::prtMarkerSuppliesMaxCapacity.1.11 = 320000
PRINTER-MIB::prtMarkerSuppliesMaxCapacity.1.12 = 480000
PRINTER-MIB::prtMarkerSuppliesMaxCapacity.1.13 = 200000
PRINTER-MIB::prtMarkerSuppliesLevel.1.1 = 5060
PRINTER-MIB::prtMarkerSuppliesLevel.1.2 = 4620
PRINTER-MIB::prtMarkerSuppliesLevel.1.3 = 20900
PRINTER-MIB::prtMarkerSuppliesLevel.1.4 = 24960
PRINTER-MIB::prtMarkerSuppliesLevel.1.5 = 14520
PRINTER-MIB::prtMarkerSuppliesLevel.1.6 = 14300

PRINTER-MIB::prtMediaPathType.1.1 = simplex
PRINTER-MIB::prtMediaPathType.1.2 = longEdgeBindingDuplex
PRINTER-MIB::prtMediaPathDescription.1.1 = Hauptpapierpfad
PRINTER-MIB::prtMediaPathDescription.1.2 = Duplex-Papierpfad
PRINTER-MIB::prtMediaPathStatus.1.1 = 4
PRINTER-MIB::prtMediaPathStatus.1.2 = 4


PRINTER-MIB::prtConsoleLightTable
PRINTER-MIB::prtConsoleOnTime.1.1 = 0
PRINTER-MIB::prtConsoleOffTime.1.1 = 0
PRINTER-MIB::prtConsoleColor.1.1 = unknown_0
PRINTER-MIB::prtConsoleDescription.1.1 =
PRINTER-MIB::prtAlertTable
PRINTER-MIB::prtAlertSeverityLevel.1.61 = warningUnaryChangeEvent
PRINTER-MIB::prtAlertSeverityLevel.1.62 = warningUnaryChangeEvent
PRINTER-MIB::prtAlertTrainingLevel.1.61 = untrained
PRINTER-MIB::prtAlertTrainingLevel.1.62 = untrained
PRINTER-MIB::prtAlertGroup.1.61 = input
PRINTER-MIB::prtAlertGroup.1.62 = input
PRINTER-MIB::prtAlertGroupIndex.1.61 = 8
PRINTER-MIB::prtAlertGroupIndex.1.62 = 8
PRINTER-MIB::prtAlertLocation.1.61 = -2
PRINTER-MIB::prtAlertLocation.1.62 = -2

LEXMARK-PVT-MIB::prtgenStatusTable
LEXMARK-PVT-MIB::prtgenStatPrinterIndex.1 = 1
LEXMARK-PVT-MIB::prtgenStatusIRC.1 = 0
LEXMARK-PVT-MIB::prtgenStatusOutHopFull.1 = notFull
LEXMARK-PVT-MIB::prtgenStatusInputEmpty.1 = notEmpty
LEXMARK-PVT-MIB::prtgenStatusPaperJam.1 = notJammed
LEXMARK-PVT-MIB::prtgenStatusTonerError.1 = noTonerError
LEXMARK-PVT-MIB::prtgenStatusSrvcReqd.1 = noServiceRequired
LEXMARK-PVT-MIB::prtgenStatusDiskError.1 = noDiskError
LEXMARK-PVT-MIB::prtgenStatusCoverOpen.1 = noCoverOpen
LEXMARK-PVT-MIB::prtgenStatusPageComplex.1 = noComplexPage
LEXMARK-PVT-MIB::prtgenStatusLineStatus.1 = online
LEXMARK-PVT-MIB::prtgenStatusBusy.1 = unknown
LEXMARK-PVT-MIB::prtgenStatusWaiting.1 = unknown
LEXMARK-PVT-MIB::prtgenStatusWarming.1 = unknown
LEXMARK-PVT-MIB::prtgenStatusPrinting.1 = unknown

LEXMARK-MPS-MIB::deviceModel.1 = Lexmark X950
LEXMARK-MPS-MIB::deviceSerialNumber.1 = 7558100451987

LEXMARK-MPS-MIB::hwInventoryType.1.1 = printEngine
LEXMARK-MPS-MIB::hwInventoryType.1.2 = electronicCard
LEXMARK-MPS-MIB::hwInventoryType.1.3 = other
LEXMARK-MPS-MIB::hwInventoryType.1.4 = inputTray
LEXMARK-MPS-MIB::hwInventoryType.1.5 = optionInputTray
LEXMARK-MPS-MIB::hwInventoryType.1.6 = optionInputTray
LEXMARK-MPS-MIB::hwInventoryType.1.7 = optionInputTray
LEXMARK-MPS-MIB::hwInventoryType.1.8 = outputTray
LEXMARK-MPS-MIB::hwInventoryType.1.9 = finishingDevice
LEXMARK-MPS-MIB::hwInventoryType.1.10 = optionOutputTray
LEXMARK-MPS-MIB::hwInventoryType.1.11 = inputTray
LEXMARK-MPS-MIB::hwInventoryType.1.12 = inputTray
LEXMARK-MPS-MIB::hwInventoryType.1.13 = duplexer
LEXMARK-MPS-MIB::hwInventoryType.1.14 = scanner
LEXMARK-MPS-MIB::hwInventoryAdminStatus.1.1 = 4
LEXMARK-MPS-MIB::hwInventoryAdminStatus.1.2 = 4
LEXMARK-MPS-MIB::hwInventoryAdminStatus.1.3 = 4
LEXMARK-MPS-MIB::hwInventoryAdminStatus.1.4 = 4
LEXMARK-MPS-MIB::hwInventoryAdminStatus.1.5 = 4
LEXMARK-MPS-MIB::hwInventoryAdminStatus.1.6 = 4
...
LEXMARK-MPS-MIB::hwInventoryDescription.1.3 = Engine Card
LEXMARK-MPS-MIB::hwInventoryDescription.1.4 = Fachÿ1
LEXMARK-MPS-MIB::hwInventoryDescription.1.5 = Fach 2
LEXMARK-MPS-MIB::hwInventoryDescription.1.6 = Fachÿ3
LEXMARK-MPS-MIB::hwInventoryDescription.1.7 = Fachÿ4
LEXMARK-MPS-MIB::hwInventoryDescription.1.8 = Standardablage
LEXMARK-MPS-MIB::hwInventoryDescription.1.9 = Stacker Unit
LEXMARK-MPS-MIB::hwInventoryDescription.1.10 = Ablageÿ1
LEXMARK-MPS-MIB::hwInventoryDescription.1.11 = Manuell



LEXMARK-MPS-MIB::currentSupplyDescription.1.2 = Magenta Toner
LEXMARK-MPS-MIB::currentSupplyDescription.1.3 = Yellow Toner
LEXMARK-MPS-MIB::currentSupplyDescription.1.4 = Black Toner
LEXMARK-MPS-MIB::currentSupplyDescription.1.5 = Photo Drum:Cyan
LEXMARK-MPS-MIB::currentSupplyDescription.1.6 = Photo Drum:Magenta
...
LEXMARK-MPS-MIB::currentSupplyCurrentStatus.1.1 = ok
LEXMARK-MPS-MIB::currentSupplyCurrentStatus.1.2 = ok
LEXMARK-MPS-MIB::currentSupplyCurrentStatus.1.3 = ok
LEXMARK-MPS-MIB::currentSupplyCurrentStatus.1.4 = ok
LEXMARK-MPS-MIB::currentSupplyCurrentStatus.1.5 = ok
LEXMARK-MPS-MIB::currentSupplyCurrentStatus.1.6 = ok
LEXMARK-MPS-MIB::currentSupplyCurrentStatus.1.7 = ok

LEXMARK-MPS-MIB::deviceAlertTable
LEXMARK-MPS-MIB::deviceAlertConfigTableNode.1.61 = hwInventoryTable
LEXMARK-MPS-MIB::deviceAlertConfigTableNode.1.62 = hwInventoryTable
LEXMARK-MPS-MIB::deviceAlertConfigTableIndex.1.61 = 7
LEXMARK-MPS-MIB::deviceAlertConfigTableIndex.1.62 = 4
LEXMARK-MPS-MIB::deviceAlertSeverity.1.61 = warning
LEXMARK-MPS-MIB::deviceAlertSeverity.1.62 = warning

