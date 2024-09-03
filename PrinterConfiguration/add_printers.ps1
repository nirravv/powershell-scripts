# Define a list of printers with their names and IP addresses
$printers = @(
    @{Name="Printer1"; IP="192.168.1.101"},
    @{Name="Printer2"; IP="192.168.1.102"},
    @{Name="Printer3"; IP="192.168.1.103"}
)

# Function to find the best driver for a printer
function Get-BestPrinterDriver {
    param (
        [string]$PrinterName
    )

    # Query installed drivers and try to match the printer name
    $driver = Get-PrinterDriver | Where-Object { $_.Name -like "*$PrinterName*" }

    if ($driver) {
        return $driver.Name
    } else {
        Write-Host "No matching driver found for $PrinterName, attempting to use generic driver..."
        # Optionally, return a generic driver if no match is found
        return "Generic / Text Only"
    }
}

# Loop through each printer in the list
foreach ($printer in $printers) {
    $printerName = $printer.Name
    $printerIP = $printer.IP

    # Define the printer port name
    $portName = "$printerIP:9100"

    # Add a TCP/IP printer port
    Write-Host "Creating port for $printerName with IP $printerIP"
    Add-PrinterPort -Name $portName -PrinterHostAddress $printerIP

    # Get the best possible driver
    $driverName = Get-BestPrinterDriver -PrinterName $printerName

    # Add the printer using the best driver
    Write-Host "Adding printer $printerName with IP $printerIP using driver $driverName"
    Add-Printer -Name $printerName -PortName $portName -DriverName $driverName

    # Optional: Set the printer as the default
    # Write-Host "Setting $printerName as the default printer"
    # Set-DefaultPrinter -Name $printerName
}

Write-Host "Printers have been added successfully."
