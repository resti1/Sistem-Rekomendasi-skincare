#include <windows.h>
#include <cstdlib>
#include <iostream>
#include <mysql/mysql.h>
#include <mysql/mysqld_error.h>
#include <algorithm>
#include <vector>
#include <iomanip>

using namespace std;

const char *host = "localhost";
const char *user = "root";
const char *pass = "";
const char *db = "skincare";
int port = 0;
char *sck = NULL;
int flags = 0;
MYSQL *conn;
MYSQL *koneksi;

class DatabaseManager {
public:
    // Definisi fungsi-fungsi untuk manajemen database
    bool connect(const char* host, const char* user, const char* password, const char* database);
    void disconnect();
    void runQuery(const std::string& query);
    std::string getSkincareName(double recommendation);
};

bool DatabaseManager::connect(const char* host, const char* user, const char* password, const char* database) {
    conn = mysql_init(NULL);
    if (conn == NULL) {
        cout << "Terjadi Kesalahan!! \n";
        return false;
    }
    koneksi = mysql_real_connect(conn, host, user, password, database, port, sck, flags);
    if (koneksi == NULL) {
        cout << "Gagal Terhubung ke MYSQL! \n";
        cout << "Periksa kembali konfigurasi \n";
        Sleep(2000);
        return false;
    } else {
        Sleep(2000);
        return true;
    }
}

void DatabaseManager::disconnect() {
    mysql_close(conn);
}

void DatabaseManager::runQuery(const std::string& query) {
    if (mysql_query(conn, query.c_str())) {
        cout << "Query error: " << mysql_error(conn) << endl;
    } else {
        MYSQL_RES *result = mysql_store_result(conn);
        if (result != NULL) {
            int num_fields = mysql_num_fields(result);
            MYSQL_ROW row;

        	std::cout << std::setw(4) << "No" << std::setw(10) << "Nama" << std::setw(20) << "Tanggal" << std::setw(15) << "Rekomendasi" << std::endl;
            std::cout << "--------------------------------------------\n";

            int counter = 1;
            while ((row = mysql_fetch_row(result))) {
                std::cout << std::setw(4) << counter++
                          << std::setw(10) << row[1]
                          << std::setw(20) << row[2]
                          << std::setw(15) << row[3] << std::endl;
            }

            mysql_free_result(result);
        }
   }
}


std::string DatabaseManager::getSkincareName(double recommendation) {
    std::vector<std::string> skincareNames;  // vektor untuk menyimpan banyak rekomendasi 

    std::string query = "SELECT ingredient_name FROM skincare_recommendations WHERE recommendation_score = " + std::to_string(recommendation);

    if (mysql_query(conn, query.c_str())) {
        cout << "Query error: " << mysql_error(conn) << endl;
    } else {
        MYSQL_RES *result = mysql_store_result(conn);

        if (result != NULL) {
            int num_fields = mysql_num_fields(result);
            MYSQL_ROW row;

            // Print "Detail Rekomendasi:" only once
            cout << "Detail Rekomendasi:" << endl;

            int counter = 1;  // Counter for numbering the details

            while ((row = mysql_fetch_row(result))) {
                for (int i = 0; i < num_fields; i++) {
                    std::string recommendation = row[i];

                    // Check if the recommendation is not already in the vector
                    if (std::find(skincareNames.begin(), skincareNames.end(), recommendation) == skincareNames.end()) {
                        cout << counter++ << ". " << recommendation << endl;
                        skincareNames.push_back(recommendation);  // Store the recommendation in the vector
                    }
                } 
            }

            mysql_free_result(result);
        } else {
            cout << "Query result is empty." << endl;
        }
    }

    return "";  // Return an empty string as we are using the vector to store recommendations
}



// Fungsi untuk mengevaluasi aturan fuzzy
double evaluateRule(double pH, double skinType) {
    return std::min(1.0, pH + skinType);
}


void performConsultation() {
    // Input variables
    std::string Nama, pHInput, skinTypeInput;
    double phValue, skinTypeValue;
    
    std::cout << "Masukkan nama anda: ";
    std::cin >> Nama;
	
	std::cout << "Pilihan pH \n";
	std::cout << "Sangat Asam = 1 \n";
	std::cout << "Asam = 2 \n";
	std::cout << "Sedikit Asam = 3 \n";
	std::cout << "Netral = 4 \n";
	std::cout << "Sedikit basa = 5 \n";
	std::cout << "basa = 6 \n";

    std::cout << "Masukkan pH kulit (1 , 2 , 3 , 4 , 5 , 6): ";
    std::cin >> pHInput;

    std::cout << "Masukkan jenis kulit (kering, normal, berminyak): ";
    std::cin >> skinTypeInput;

    // Konversi input pH ke nilai fuzzy	
	if (pHInput == "1"){
		phValue = 0.1;
	} else if (pHInput == "2"){
		phValue = 0.2;
	} else if (pHInput == "3"){
		phValue = 0.3;
	} else if (pHInput == "4"){
		phValue = 0.4;
	} else if (pHInput == "5"){
		phValue = 0.5;
	} else if (pHInput == "6"){
		phValue = 0.6;
	} else {
		phValue =1;
	}
	
    // Konversi input jenis kulit ke nilai fuzzy
    if (skinTypeInput == "kering"){
		skinTypeValue = 0.0;
	} else if (skinTypeInput == "normal"){
		skinTypeValue = 0.1;
	}else if (skinTypeInput == "normal"){
		skinTypeValue = 0.2;
	} else {
		skinTypeValue = 1;
	}

    double recommendation = evaluateRule(phValue, skinTypeValue) ;
									  
	 std::cout << "Rekomendasi kandungan skincare: " << recommendation << std::endl;

    // Interaksi dengan MySQL untuk mendapatkan kandungan skincare berdasarkan rekomendasi
    DatabaseManager dbManager;
    if (dbManager.connect("localhost", "root", "", "skincare")) {
        // Query ke database
        std::string query = "INSERT INTO consultation_history (nama, tanggal_konsultasi, hasil_diagnosa) VALUES ('" + Nama + "', CURDATE(), '" + std::to_string(recommendation) + "')";
        dbManager.runQuery(query);
        std::string skincareName = dbManager.getSkincareName(recommendation);

        if (!skincareName.empty()) {
            cout << "Detail Rekomendasi:\n" << skincareName << endl;
        }

        dbManager.disconnect();
    } else {
        cout << "Gagal Terhubung ke MYSQL!" << endl;
    }

    // Prompt to continue
    std::cout << "Tekan Enter untuk melanjutkan...";
    std::cin.ignore();  // Ignore any previous newline character
    std::cin.get();     // Wait for Enter key
}


void displayConsultationHistory(DatabaseManager& dbManager) {
    std::cout << "=== Histori Konsultasi ===\n";

    // Check connection
    if (dbManager.connect("localhost", "root", "", "skincare")) {
        // Execute the query to get consultation history
        std::string query = "SELECT * FROM consultation_history";
        dbManager.runQuery(query);

        dbManager.disconnect();
    } else {
        // Disconnect after using
        std::cout << "Gagal Terhubung ke MYSQL!" << std::endl;
    }
}


int main() {
    int menuChoice;
    DatabaseManager dbManager; 

    do {
        // Display the main menu
        std::cout << "=== Main Menu ===\n";
        std::cout << "1. Konsultasi\n";
        std::cout << "2. Histori Konsultasi\n";
        std::cout << "3. Keluar\n";
        std::cout << "Pilih menu (1-3): ";
        std::cin >> menuChoice;

        switch (menuChoice) {
            case 1:
                // Perform consultation
                performConsultation();
                break;
           case 2: 
			    displayConsultationHistory(dbManager);
			    break;
            case 3:
                std::cout << "Keluar dari program. Sampai jumpa!\n";
                break;
            default:
                std::cout << "Pilihan tidak valid. Silakan pilih lagi.\n";
        }

    } while (menuChoice != 3);  // Continue until the user chooses to exit

    return 0;
}


