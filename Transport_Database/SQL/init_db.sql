BEGIN;

-- Table des unités de mesure (pour gérer le poids des produits)
CREATE TABLE IF NOT EXISTS unit (
  id SERIAL PRIMARY KEY,
  code VARCHAR(20) UNIQUE NOT NULL,
  label VARCHAR(50) NOT NULL
);

-- Table des adresses
CREATE TABLE IF NOT EXISTS address (
  id SERIAL PRIMARY KEY,
  street VARCHAR(255),
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100),
  country VARCHAR(100) NOT NULL,
  postal_code VARCHAR(20),
  latitude DECIMAL(9,6),
  longitude DECIMAL(9,6),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_address_city ON address(city);
CREATE INDEX IF NOT EXISTS idx_address_country ON address(country);

-- Entreprise (tenant)
CREATE TABLE IF NOT EXISTS company (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  phone VARCHAR(20),
  address_id INT REFERENCES address(id) ON DELETE SET NULL,
  timezone VARCHAR(50) DEFAULT 'UTC', 
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_company_name ON company(name);

-- Clients
CREATE TABLE IF NOT EXISTS customer (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  phone VARCHAR(20),
  address_id INT REFERENCES address(id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_customer_company ON customer(company_id);
CREATE INDEX IF NOT EXISTS idx_customer_name ON customer(name);

-- Entrepôts
CREATE TABLE IF NOT EXISTS warehouse (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  address_id INT REFERENCES address(id) ON DELETE SET NULL,
  capacity INT CHECK (capacity >= 0),
  warehouse_type VARCHAR(50),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_warehouse_company ON warehouse(company_id);

-- Camions
CREATE TABLE IF NOT EXISTS truck (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE,
  license_plate VARCHAR(20) UNIQUE NOT NULL,
  capacity INT CHECK (capacity >= 0),
  model VARCHAR(50),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_truck_company ON truck(company_id);

-- Chauffeurs
CREATE TABLE IF NOT EXISTS driver (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  license_number VARCHAR(50),
  license_expiry_date DATE,
  phone VARCHAR(20),
  driver_status VARCHAR(50) DEFAULT 'ACTIVE',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_driver_company ON driver(company_id);

-- Produits
CREATE TABLE IF NOT EXISTS product (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  weight INT CHECK (weight >= 0),
  unit_id INT REFERENCES unit(id) ON DELETE SET NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_product_company ON product(company_id);

-- Tables de statuts
CREATE TABLE IF NOT EXISTS order_status (
  id SERIAL PRIMARY KEY,
  code VARCHAR(50) UNIQUE NOT NULL,
  label VARCHAR(100),
  is_final BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS shipment_status (
  id SERIAL PRIMARY KEY,
  code VARCHAR(50) UNIQUE NOT NULL,
  label VARCHAR(100),
  is_final BOOLEAN DEFAULT FALSE
);

-- Commandes
CREATE TABLE IF NOT EXISTS "order" (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE,
  customer_id INT REFERENCES customer(id) ON DELETE SET NULL,
  warehouse_id INT REFERENCES warehouse(id) ON DELETE SET NULL,
  total_weight INT CHECK (total_weight >= 0),
  status_id INT REFERENCES order_status(id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_order_company ON "order"(company_id);
CREATE INDEX IF NOT EXISTS idx_order_status ON "order"(status_id);

-- Détails de commande
CREATE TABLE IF NOT EXISTS order_item (
  id SERIAL PRIMARY KEY,
  order_id INT NOT NULL REFERENCES "order"(id) ON DELETE CASCADE,
  product_id INT REFERENCES product(id) ON DELETE SET NULL,
  quantity INT CHECK (quantity > 0),
  unit_weight INT CHECK (unit_weight >= 0),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_order_item_order ON order_item(order_id);

-- Routes (itinéraires)
CREATE TABLE IF NOT EXISTS route (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE,
  name VARCHAR(100),
  start_warehouse_id INT REFERENCES warehouse(id) ON DELETE SET NULL,
  end_warehouse_id INT REFERENCES warehouse(id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_route_company ON route(company_id);

-- Étapes intermédiaires (arrêts)
CREATE TABLE IF NOT EXISTS route_stop (
  id SERIAL PRIMARY KEY,
  route_id INT NOT NULL REFERENCES route(id) ON DELETE CASCADE,
  warehouse_id INT REFERENCES warehouse(id) ON DELETE SET NULL,
  stop_order INT CHECK (stop_order > 0),
  stop_type VARCHAR(50) DEFAULT 'WAREHOUSE', 
  arrival_eta TIMESTAMP,
  departure_eta TIMESTAMP,
  actual_arrival TIMESTAMP,
  actual_departure TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_route_stop_route ON route_stop(route_id);

-- Expéditions
CREATE TABLE IF NOT EXISTS shipment (
  id SERIAL PRIMARY KEY,
  order_id INT NOT NULL REFERENCES "order"(id) ON DELETE CASCADE,
  truck_id INT REFERENCES truck(id) ON DELETE SET NULL,
  driver_id INT REFERENCES driver(id) ON DELETE SET NULL,
  route_id INT REFERENCES route(id) ON DELETE SET NULL,
  status_id INT REFERENCES shipment_status(id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_shipment_order ON shipment(order_id);
CREATE INDEX IF NOT EXISTS idx_shipment_status ON shipment(status_id);

-- Evénements d’expédition (historique)
CREATE TABLE IF NOT EXISTS shipment_event (
  id SERIAL PRIMARY KEY,
  shipment_id INT NOT NULL REFERENCES shipment(id) ON DELETE CASCADE,
  event_status_id INT REFERENCES shipment_status(id) ON DELETE SET NULL,
  event_time TIMESTAMP DEFAULT NOW(),
  comment TEXT
);
CREATE INDEX IF NOT EXISTS idx_shipment_event_shipment ON shipment_event(shipment_id);

-- Utilisateurs internes (employés, administrateurs, etc.)
CREATE TABLE IF NOT EXISTS "user" (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  name VARCHAR(100),
  role VARCHAR(50) DEFAULT 'USER' CHECK (role IN ('ADMIN','MANAGER','USER')),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_user_company ON "user"(company_id);
CREATE INDEX IF NOT EXISTS idx_user_role ON "user"(role);

-- Factures liées à des commandes
CREATE TABLE IF NOT EXISTS invoice (
  id SERIAL PRIMARY KEY,
  order_id INT NOT NULL REFERENCES "order"(id) ON DELETE CASCADE,
  invoice_number VARCHAR(50) UNIQUE NOT NULL,
  amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
  currency VARCHAR(10) DEFAULT 'EUR' CHECK (currency IN ('EUR','USD','GBP')),
  issued_at TIMESTAMP DEFAULT NOW(),
  paid_at TIMESTAMP,
  due_date TIMESTAMP,
  status VARCHAR(50) DEFAULT 'PENDING' CHECK (status IN ('PENDING','PAID','OVERDUE')),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_invoice_order ON invoice(order_id);
CREATE INDEX IF NOT EXISTS idx_invoice_status ON invoice(status);

-- Paiements effectués sur une facture
CREATE TABLE IF NOT EXISTS payment (
  id SERIAL PRIMARY KEY,
  invoice_id INT NOT NULL REFERENCES invoice(id) ON DELETE CASCADE,
  payment_method VARCHAR(50) CHECK (payment_method IN ('CARD','BANK_TRANSFER','CASH')),
  amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
  paid_at TIMESTAMP DEFAULT NOW(),
  note TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_payment_invoice ON payment(invoice_id);

-- Maintenance des camions (historique des révisions, réparations)
CREATE TABLE IF NOT EXISTS truck_maintenance (
  id SERIAL PRIMARY KEY,
  truck_id INT NOT NULL REFERENCES truck(id) ON DELETE CASCADE,
  maintenance_date TIMESTAMP DEFAULT NOW(),
  description TEXT,
  cost DECIMAL(10,2) NOT NULL CHECK (cost >= 0),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_truck_maintenance_truck ON truck_maintenance(truck_id);

-- Table pour stocker des KPI calculés périodiquement (journaliers, hebdomadaires)
CREATE TABLE IF NOT EXISTS kpi_snapshot (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE,
  period_start DATE NOT NULL,
  period_end DATE NOT NULL,
  total_orders INT CHECK (total_orders >= 0),
  on_time_deliveries INT CHECK (on_time_deliveries >= 0),
  late_deliveries INT CHECK (late_deliveries >= 0),
  total_revenue DECIMAL(10,2) CHECK (total_revenue >= 0),
  total_costs DECIMAL(10,2) CHECK (total_costs >= 0),
  created_at TIMESTAMP DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_kpi_company ON kpi_snapshot(company_id);

-- Notifications internes (par exemple : stock faible, facture en retard, etc.)
CREATE TABLE IF NOT EXISTS notification (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE,
  user_id INT REFERENCES "user"(id) ON DELETE SET NULL,
  notification_type VARCHAR(50), 
  message TEXT,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_notification_company ON notification(company_id);

COMMIT;
