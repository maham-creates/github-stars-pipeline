import zipfile
import duckdb
import os


def extract_zip_file(zip_file_path, extract_to_dir):
    with zipfile.ZipFile(zip_file_path, "r") as zip_ref:
        zip_ref.extractall(extract_to_dir)


def load_json_gz_files_in_duck_db(json_dir):
    # Create a connection to the DuckDB database
    con = duckdb.connect("github_stars.db")

    # Create the source schema if it doesn't exist
    con.sql("CREATE SCHEMA IF NOT EXISTS source")

    # Use a wildcard to load all .json.gz files in the directory into DuckDB
    con.sql(f"""
        CREATE OR REPLACE TABLE source.src_gharchive AS
        SELECT * FROM read_json_auto('{json_dir}/*.json.gz')
    """)

    # Close the connection
    con.close()


# to test:
if __name__ == "__main__":
    # Example file path: replace this with your actual zip file path and extraction directory
    zip_file = os.path.join(".", "data", "gharchive_sample.zip")
    output_dir = os.path.join(".", "tmp")
    json_dir = os.path.join(output_dir, "gharchive_sample")

    # Call the function
    extract_zip_file(zip_file, output_dir)
    load_json_gz_files_in_duck_db(json_dir)
    print("Data loading successful!")
