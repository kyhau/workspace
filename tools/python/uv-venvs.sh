#!/bin/bash

# uv-venvs.sh - Virtual Environment Management Script
# Manages uv virtual environments in a centralized location

# Default virtual environments directory
UV_VENVS_DIR="$HOME/.venvs"

# Default Python version (will be set from UV_PYTHON if available)
DEFAULT_PYTHON_VERSION="3.13"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  list                    List all virtual environments"
    echo "  create <name> [python_version] Create a new virtual environment"
    echo "  delete <name>           Delete an existing virtual environment"
    echo "  activate <name>         Show activation command for environment"
    echo "  info <name>             Show information about an environment"
    echo "  help                    Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 list"
    echo "  $0 create myproject                   # Uses default Python version"
    echo "  $0 create myproject 3.12              # Uses Python 3.12"
    echo "  $0 create myproject 3.11              # Uses Python 3.11"
    echo "  $0 delete oldproject"
    echo "  $0 activate myproject"
    echo ""
    echo "Environment:"
    echo "  UV_VENVS_DIR: $UV_VENVS_DIR"
    echo "  Default Python: $DEFAULT_PYTHON_VERSION"
    echo ""
}

# Function to get Python version from UV_PYTHON if available
get_default_python() {
    if [[ -n "$UV_PYTHON" ]]; then
        echo "$UV_PYTHON"
    else
        echo "$DEFAULT_PYTHON_VERSION"
    fi
}

# Function to list all virtual environments
list_venvs() {
    print_info "Virtual environments in $UV_VENVS_DIR:"
    echo ""

    if [[ ! -d "$UV_VENVS_DIR" ]]; then
        print_warning "Directory $UV_VENVS_DIR does not exist"
        return 1
    fi

    local count=0
    for venv in "$UV_VENVS_DIR"/*; do
        if [[ -d "$venv" && -f "$venv/pyvenv.cfg" ]]; then
            local venv_name=$(basename "$venv")
            local python_version=""

            # Try to get Python version from pyvenv.cfg
            if [[ -f "$venv/pyvenv.cfg" ]]; then
                python_version=$(grep "version" "$venv/pyvenv.cfg" | cut -d'=' -f2 | tr -d ' ')
            fi

            # Try to get Python version from actual Python binary
            if [[ -x "$venv/bin/python" ]]; then
                python_version=$("$venv/bin/python" --version 2>&1 | grep -oE '[0-9]+\.[0-9]+' | head -1)
            fi

            echo "  📁 $venv_name (Python $python_version)"
            ((count++))
        fi
    done

    if [[ $count -eq 0 ]]; then
        print_warning "No virtual environments found"
    else
        echo ""
        print_success "Found $count virtual environment(s)"
    fi
}

# Function to create a new virtual environment
create_venv() {
    local venv_name="$1"
    local python_version="$2"

    if [[ -z "$venv_name" ]]; then
        print_error "Virtual environment name is required"
        echo "Usage: $0 create <name> [python_version]"
        return 1
    fi

    # Use provided version or default
    if [[ -z "$python_version" ]]; then
        python_version=$(get_default_python)
    fi

    local venv_path="$UV_VENVS_DIR/$venv_name"

    # Check if environment already exists
    if [[ -d "$venv_path" ]]; then
        print_error "Virtual environment '$venv_name' already exists at $venv_path"
        return 1
    fi

    # Create directory if it doesn't exist
    mkdir -p "$UV_VENVS_DIR"

    print_info "Creating virtual environment '$venv_name' with Python $python_version..."

    # Create virtual environment
    if uv venv --python "$python_version" "$venv_path"; then
        print_success "Virtual environment '$venv_name' created successfully"
        echo ""
        print_info "To activate this environment:"
        echo "  source $venv_path/bin/activate"
        echo ""
        print_info "Or use: $0 activate $venv_name"
    else
        print_error "Failed to create virtual environment '$venv_name'"
        return 1
    fi
}

# Function to delete a virtual environment
delete_venv() {
    local venv_name="$1"

    if [[ -z "$venv_name" ]]; then
        print_error "Virtual environment name is required"
        echo "Usage: $0 delete <name>"
        return 1
    fi

    local venv_path="$UV_VENVS_DIR/$venv_name"

    # Check if environment exists
    if [[ ! -d "$venv_path" ]]; then
        print_error "Virtual environment '$venv_name' does not exist at $venv_path"
        return 1
    fi

    # Confirm deletion
    print_warning "Are you sure you want to delete virtual environment '$venv_name'?"
    print_warning "This will permanently remove: $venv_path"
    read -p "Type 'yes' to confirm: " confirm

    if [[ "$confirm" == "yes" ]]; then
        if rm -rf "$venv_path"; then
            print_success "Virtual environment '$venv_name' deleted successfully"
        else
            print_error "Failed to delete virtual environment '$venv_name'"
            return 1
        fi
    else
        print_info "Deletion cancelled"
    fi
}

# Function to show activation command
activate_venv() {
    local venv_name="$1"

    if [[ -z "$venv_name" ]]; then
        print_error "Virtual environment name is required"
        echo "Usage: $0 activate <name>"
        return 1
    fi

    local venv_path="$UV_VENVS_DIR/$venv_name"

    # Check if environment exists
    if [[ ! -d "$venv_path" ]]; then
        print_error "Virtual environment '$venv_name' does not exist at $venv_path"
        return 1
    fi

    print_info "To activate virtual environment '$venv_name':"
    echo "  source $venv_path/bin/activate"
    echo ""
    print_info "To deactivate:"
    echo "  deactivate"
}

# Function to show environment information
info_venv() {
    local venv_name="$1"

    if [[ -z "$venv_name" ]]; then
        print_error "Virtual environment name is required"
        echo "Usage: $0 info <name>"
        return 1
    fi

    local venv_path="$UV_VENVS_DIR/$venv_name"

    # Check if environment exists
    if [[ ! -d "$venv_path" ]]; then
        print_error "Virtual environment '$venv_name' does not exist at $venv_path"
        return 1
    fi

    print_info "Virtual Environment Information:"
    echo "  Name: $venv_name"
    echo "  Path: $venv_path"

    # Get Python version
    if [[ -x "$venv_path/bin/python" ]]; then
        local python_version=$("$venv_path/bin/python" --version 2>&1)
        echo "  Python: $python_version"
    fi

    # Get pip version
    if [[ -x "$venv_path/bin/pip" ]]; then
        local pip_version=$("$venv_path/bin/pip" --version 2>&1)
        echo "  Pip: $pip_version"
    fi

    # List installed packages
    if [[ -x "$venv_path/bin/pip" ]]; then
        echo ""
        print_info "Installed packages:"
        "$venv_path/bin/pip" list --format=columns 2>/dev/null || echo "  (Unable to list packages)"
    fi
}

# Main script logic
main() {
    local command="$1"

    case "$command" in
        "list")
            list_venvs
            ;;
        "create")
            create_venv "$2" "$3"
            ;;
        "delete")
            delete_venv "$2"
            ;;
        "activate")
            activate_venv "$2"
            ;;
        "info")
            info_venv "$2"
            ;;
        "help"|"--help"|"-h")
            show_usage
            ;;
        "")
            show_usage
            ;;
        *)
            print_error "Unknown command: $command"
            echo ""
            show_usage
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"
