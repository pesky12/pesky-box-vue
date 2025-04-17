# Build and test PeskyBoxVue locally
$ErrorActionPreference = "Stop"

Write-Host "Starting local build and test process..." -ForegroundColor Cyan
Write-Host "----------------------------------------" -ForegroundColor Cyan

# Step 1: Check if banner.png exists, if not create a placeholder
Write-Host "Checking for banner image..." -ForegroundColor Green
if (-not (Test-Path "src/assets/banner.png")) {
    Write-Host "Banner image not found. Creating a placeholder..." -ForegroundColor Yellow
    # Create a simple placeholder or copy from an existing image
    if (Test-Path "src/assets/logo.png") {
        Copy-Item "src/assets/logo.png" "src/assets/banner.png"
    } else {
        Write-Host "No logo found for placeholder. Please add a banner.png file to src/assets/" -ForegroundColor Yellow
    }
}

# Step 2: Install dependencies if needed
Write-Host "Installing dependencies..." -ForegroundColor Green
npm install

# Step 3: Build the Vue application
Write-Host "Building Vue application..." -ForegroundColor Green
npm run build

# Step 4: Create the listing directory structure
Write-Host "Preparing listing directory..." -ForegroundColor Green
New-Item -ItemType Directory -Path "dist/listing" -Force | Out-Null
Copy-Item "src/assets/source.json" "dist/listing/"
Copy-Item "src/assets/banner.png" "dist/listing/" -ErrorAction SilentlyContinue

# Step 5: Clone or update the package-list-action repository
Write-Host "Setting up package-list-action..." -ForegroundColor Green
$packageListActionPath = "../package-list-action"
if (-not (Test-Path $packageListActionPath)) {
    Write-Host "Cloning package-list-action repository..." -ForegroundColor Yellow
    git clone https://github.com/pimaker/package-list-action.git $packageListActionPath
} else {
    Write-Host "Updating package-list-action repository..." -ForegroundColor Yellow
    Set-Location $packageListActionPath
    git pull
    Set-Location "../pesky-box-vue"
}

# Step 6: Run the package list generator
Write-Host "Running package list generator..." -ForegroundColor Green
try {
    Push-Location $packageListActionPath
    dotnet run --project PackageBuilder/PackageBuilder.csproj -- `
        --package-listing-source-folder "../pesky-box-vue/dist/listing" `
        --package-listing-target-folder "../pesky-box-vue/dist"
    Pop-Location
} catch {
    Write-Host "Error running package list generator: $_" -ForegroundColor Red
    Pop-Location
    exit 1
}

# Step 7: Verify the output files
Write-Host "Verifying output files..." -ForegroundColor Green
$requiredFiles = @("index.json", "app.js", "index.html")
$missingFiles = $false
foreach ($file in $requiredFiles) {
    if (-not (Test-Path "dist/$file")) {
        Write-Host "Missing required file: $file" -ForegroundColor Red
        $missingFiles = $true
    }
}

if ($missingFiles) {
    Write-Host "Some required files are missing. Build may have failed." -ForegroundColor Red
} else {
    Write-Host "All required files are present." -ForegroundColor Green
}

# Step 8: Start a local server to test the build
Write-Host "Starting local server..." -ForegroundColor Green
Write-Host "You can access your site at http://localhost:5000" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop the server when you're done testing." -ForegroundColor Cyan
Write-Host "----------------------------------------" -ForegroundColor Cyan

# Check if npx is available
$npxAvailable = $null
try {
    $npxAvailable = Get-Command npx -ErrorAction SilentlyContinue
} catch {
    $npxAvailable = $null
}

if ($npxAvailable) {
    # Use npx serve if available
    npx serve -s dist
} else {
    # Fallback to a basic Python HTTP server if available
    $pythonAvailable = $null
    try {
        $pythonAvailable = Get-Command python -ErrorAction SilentlyContinue
    } catch {
        try {
            $pythonAvailable = Get-Command py -ErrorAction SilentlyContinue
        } catch {
            $pythonAvailable = $null
        }
    }
    
    if ($pythonAvailable) {
        Set-Location dist
        Write-Host "Using Python HTTP server..." -ForegroundColor Yellow
        
        # Check Python version to determine correct http.server command
        $pythonVersion = (& python -V 2>&1) -or (& py -V 2>&1)
        if ($pythonVersion -match "Python 3") {
            python -m http.server 5000
        } else {
            python -m SimpleHTTPServer 5000
        }
    } else {
        Write-Host "No local server tools found. Please install Node.js or Python to run a local server." -ForegroundColor Red
        Write-Host "You can manually view the files in the 'dist' folder." -ForegroundColor Yellow
    }
}
