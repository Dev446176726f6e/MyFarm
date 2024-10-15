CREATE TABLE farmers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE farms (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location TEXT NOT NULL,
    farmer_id INT REFERENCES farmers(id) ON DELETE CASCADE,
    size_acres DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE fields (
    id SERIAL PRIMARY KEY,
    farm_id INT REFERENCES farms(id) ON DELETE CASCADE,
    field_name VARCHAR(100) NOT NULL,
    area DECIMAL(10, 2),  -- in acres or hectares
    soil_type VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE crops (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    variety VARCHAR(100),
    planting_date DATE,
    harvesting_date DATE,
    field_id INT REFERENCES fields(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE workers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    farm_id INT REFERENCES farms(id) ON DELETE CASCADE,
    role VARCHAR(100),  -- e.g., operator, supervisor, laborer
    phone VARCHAR(20),
    hired_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE farm_events (
    id SERIAL PRIMARY KEY,
    farm_id INT REFERENCES farms(id) ON DELETE CASCADE,
    event_type VARCHAR(100),  -- e.g., maintenance, sensor alert, irrigation
    description TEXT,
    event_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE notifications (
    id SERIAL PRIMARY KEY,
    farmer_id INT REFERENCES farmers(id) ON DELETE CASCADE,
    message TEXT,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    tag_id VARCHAR(50) UNIQUE NOT NULL,  -- animal's unique tag or ID number
    species_id INT REFERENCES animal_species(id) ON DELETE CASCADE,
    breed_id INT REFERENCES animal_breeds(id) ON DELETE CASCADE,
    name VARCHAR(100),  -- animal name (optional)
    birth_date DATE,
    gender VARCHAR(10),  -- e.g., male, female
    farm_id INT REFERENCES farms(id) ON DELETE CASCADE,
    field_id INT REFERENCES fields(id) ON DELETE CASCADE,  -- if animals are in fields/pastures
    health_status VARCHAR(100),  -- e.g., healthy, sick, injured
    weight DECIMAL(10, 2),  -- current weight in kg
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE animal_breeds (
    id SERIAL PRIMARY KEY,
    breed_name VARCHAR(100) NOT NULL,  -- e.g., Holstein for cow, Leghorn for chicken
    species_id INT REFERENCES animal_species(id) ON DELETE CASCADE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE animal_species (
    id SERIAL PRIMARY KEY,
    species_name VARCHAR(100) NOT NULL,  -- e.g., cow, chicken, sheep
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE animal_health_records (
    id SERIAL PRIMARY KEY,
    animal_id INT REFERENCES animals(id) ON DELETE CASCADE,
    checkup_date TIMESTAMP NOT NULL,
    health_status VARCHAR(100),  -- e.g., healthy, needs vaccination
    diagnosis TEXT,
    treatment TEXT,
    veterinarian VARCHAR(100),
    follow_up_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE animal_feed_records (
    id SERIAL PRIMARY KEY,
    animal_id INT REFERENCES animals(id) ON DELETE CASCADE,
    feed_type VARCHAR(100),  -- e.g., hay, grain, mixed feed
    feed_quantity DECIMAL(10, 2),  -- quantity in kg or lbs
    feed_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE animal_breeding_records (
    id SERIAL PRIMARY KEY,
    animal_id INT REFERENCES animals(id) ON DELETE CASCADE,  -- female animal
    mate_id INT REFERENCES animals(id) ON DELETE CASCADE,  -- male animal
    breeding_date DATE NOT NULL,
    pregnancy_status VARCHAR(100),  -- e.g., pregnant, not pregnant
    expected_birth_date DATE,
    birth_date DATE,  -- if pregnancy is successful
    number_of_offspring INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE animal_milk_production (
    id SERIAL PRIMARY KEY,
    animal_id INT REFERENCES animals(id) ON DELETE CASCADE,
    milking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    milk_quantity DECIMAL(10, 2),  -- quantity of milk produced in liters
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE animal_production (
    id SERIAL PRIMARY KEY,
    animal_id INT REFERENCES animals(id) ON DELETE CASCADE,
    production_type VARCHAR(100),  -- e.g., wool, meat
    quantity DECIMAL(10, 2),  -- quantity in kg
    production_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vaccination_schedule (
    id SERIAL PRIMARY KEY,
    animal_id INT REFERENCES animals(id) ON DELETE CASCADE,
    vaccine_name VARCHAR(100),
    scheduled_date DATE,
    administered_date DATE,
    veterinarian VARCHAR(100),
    status VARCHAR(50),  -- e.g., scheduled, completed
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE animal_sales_records (
    id SERIAL PRIMARY KEY,
    animal_id INT REFERENCES animals(id) ON DELETE CASCADE,
    buyer_name VARCHAR(100),
    sale_price DECIMAL(10, 2),
    sale_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);