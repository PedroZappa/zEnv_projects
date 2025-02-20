import os
import yaml
import subprocess # To run git shell commands in child processes
from colorama import Fore, Style
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Constants
INIT_FILE = "repos.yaml"  # Configuration file containing repository information
C0D3_DIR = os.path.expanduser("~/C0D3")  # Base directory for storing repositories

def load_repos():
    """
    Load the repository configuration from a YAML file.

    Returns:
        dict: A dictionary containing the repository categories and URLs.
    """
    with open(INIT_FILE, "r") as f:
        data = yaml.safe_load(f) or {}  # Ensure we return a dict, not None
        if "categories" not in data:
            data["categories"] = {}  # Ensure categories exist
        return data

def clone_or_update_repo(category, repo_url):
    """
    Clone or update a Git repository.

    Args:
        category (str): The category under which the repository is organized.
        repo_url (str): The URL of the Git repository.
    """
    # Construct paths for the category and repository
    category_path = os.path.join(C0D3_DIR, str(category))
    repo_name = repo_url.split("/")[-1].replace(".git", "")
    repo_path = os.path.join(category_path, repo_name)

    # Ensure the category directory exists
    os.makedirs(category_path, exist_ok=True)

    if os.path.exists(repo_path):
        # Update the repository if it already exists
        print(f"""
Updating {Fore.GREEN}{repo_name}{Style.RESET_ALL}...
        """)
        subprocess.run(["git", "-C", repo_path, "pull"], check=True)
    else:
        # Clone the repository if it does not exist
        print(f"""
Cloning {Fore.GREEN}{repo_name}{Style.RESET_ALL} into {Fore.YELLOW}{category_path}{Style.RESET_ALL}...
        """)
        print(f"Cloning {repo_name} into {category_path}...")
        subprocess.run(["git", "clone", repo_url, repo_path], check=True)

def main():
    """
    Main function to manage the cloning and updating of repositories.
    """
    # Ensure the base directory exists
    os.makedirs(C0D3_DIR, exist_ok=True)
    # Load repository configuration
    repos = load_repos()
    print(f"""
Repos to be loaded {Fore.GREEN}{repos}{Style.RESET_ALL}...
        """)

    # Iterate over each category and repository URL
    for category, repo_list in repos["categories"].items():
        for repo_url in repo_list:
            clone_or_update_repo(category, repo_url)

if __name__ == "__main__":
    main()
