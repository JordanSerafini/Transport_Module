BEGIN;

-- Table des unités de mesure (pour gérer le poids des produits)
CREATE TABLE IF NOT EXISTS units (
  id SERIAL PRIMARY KEY,
  code VARCHAR(20) UNIQUE NOT NULL,
  label VARCHAR(50) NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ
);

-- Table des adresses
CREATE TABLE IF NOT EXISTS addresses (
  id SERIAL PRIMARY KEY,
  street VARCHAR(255),
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100),
  country VARCHAR(100) NOT NULL,
  postal_code VARCHAR(20),
  latitude DECIMAL(9,6),
  longitude DECIMAL(9,6),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_addresses_city ON addresses(city);
CREATE INDEX IF NOT EXISTS idx_addresses_country ON addresses(country);

-- Entreprises (tenants)
CREATE TABLE IF NOT EXISTS companies (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  phone VARCHAR(20),
  address_id INT REFERENCES addresses(id) ON DELETE SET NULL,
  timezone VARCHAR(50) DEFAULT 'UTC', 
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_companies_name ON companies(name);

-- Clients
CREATE TABLE IF NOT EXISTS customers (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  phone VARCHAR(20),
  address_id INT REFERENCES addresses(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_customers_company ON customers(company_id);
CREATE INDEX IF NOT EXISTS idx_customers_name ON customers(name);

-- Entrepôts
CREATE TABLE IF NOT EXISTS warehouses (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  address_id INT REFERENCES addresses(id) ON DELETE SET NULL,
  capacity INT CHECK (capacity >= 0),
  warehouse_type VARCHAR(50),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_warehouses_company ON warehouses(company_id);

-- Camions
CREATE TABLE IF NOT EXISTS trucks (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  license_plate VARCHAR(20) UNIQUE NOT NULL,
  capacity INT CHECK (capacity >= 0),
  model VARCHAR(50),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_trucks_company ON trucks(company_id);

-- Chauffeurs
CREATE TABLE IF NOT EXISTS drivers (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  license_number VARCHAR(50),
  license_expiry_date DATE,
  phone VARCHAR(20),
  driver_status VARCHAR(50) DEFAULT 'ACTIVE',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_drivers_company ON drivers(company_id);

-- Produits
CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  weight INT CHECK (weight >= 0),
  unit_id INT REFERENCES units(id) ON DELETE SET NULL,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_products_company ON products(company_id);

-- Statuts de commandes et d'expéditions
CREATE TABLE IF NOT EXISTS order_statuses (
  id SERIAL PRIMARY KEY,
  code VARCHAR(50) UNIQUE NOT NULL,
  label VARCHAR(100),
  is_final BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS shipment_statuses (
  id SERIAL PRIMARY KEY,
  code VARCHAR(50) UNIQUE NOT NULL,
  label VARCHAR(100),
  is_final BOOLEAN DEFAULT FALSE
);

-- Commandes
CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  customer_id INT REFERENCES customers(id) ON DELETE SET NULL,
  warehouse_id INT REFERENCES warehouses(id) ON DELETE SET NULL,
  total_weight INT CHECK (total_weight >= 0),
  status_id INT REFERENCES order_statuses(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_orders_company ON orders(company_id);
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status_id);

-- Détails de commande
CREATE TABLE IF NOT EXISTS order_items (
  id SERIAL PRIMARY KEY,
  order_id INT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  product_id INT REFERENCES products(id) ON DELETE SET NULL,
  quantity INT CHECK (quantity > 0),
  unit_weight INT CHECK (unit_weight >= 0),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_order_items_order ON order_items(order_id);
-- Index composite pour les recherches spécifiques (ex: tous les produits d'une commande)
CREATE INDEX IF NOT EXISTS idx_order_items_order_product ON order_items(order_id, product_id);

-- Routes (itinéraires)
CREATE TABLE IF NOT EXISTS routes (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  name VARCHAR(100),
  start_warehouse_id INT REFERENCES warehouses(id) ON DELETE SET NULL,
  end_warehouse_id INT REFERENCES warehouses(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_routes_company ON routes(company_id);

-- Étapes intermédiaires (arrêts)
CREATE TABLE IF NOT EXISTS route_stops (
  id SERIAL PRIMARY KEY,
  route_id INT NOT NULL REFERENCES routes(id) ON DELETE CASCADE,
  warehouse_id INT REFERENCES warehouses(id) ON DELETE SET NULL,
  stop_order INT CHECK (stop_order > 0),
  stop_type VARCHAR(50) DEFAULT 'WAREHOUSE', 
  arrival_eta TIMESTAMPTZ,
  departure_eta TIMESTAMPTZ,
  actual_arrival TIMESTAMPTZ,
  actual_departure TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_route_stops_route ON route_stops(route_id);

-- Expéditions
CREATE TABLE IF NOT EXISTS shipments (
  id SERIAL PRIMARY KEY,
  order_id INT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  truck_id INT REFERENCES trucks(id) ON DELETE SET NULL,
  driver_id INT REFERENCES drivers(id) ON DELETE SET NULL,
  route_id INT REFERENCES routes(id) ON DELETE SET NULL,
  status_id INT REFERENCES shipment_statuses(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_shipments_order ON shipments(order_id);
CREATE INDEX IF NOT EXISTS idx_shipments_status ON shipments(status_id);

-- Evénements d’expédition (historique)
CREATE TABLE IF NOT EXISTS shipment_events (
  id SERIAL PRIMARY KEY,
  shipment_id INT NOT NULL REFERENCES shipments(id) ON DELETE CASCADE,
  event_status_id INT REFERENCES shipment_statuses(id) ON DELETE SET NULL,
  event_time TIMESTAMPTZ DEFAULT NOW(),
  comment TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_shipment_events_shipment ON shipment_events(shipment_id);

-- Utilisateurs internes (employés, administrateurs, etc.)
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  name VARCHAR(100),
  role VARCHAR(50) DEFAULT 'USER' CHECK (role IN ('ADMIN','MANAGER','USER')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_users_company ON users(company_id);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);

-- Factures liées à des commandes
CREATE TABLE IF NOT EXISTS invoices (
  id SERIAL PRIMARY KEY,
  order_id INT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  invoice_number VARCHAR(50) UNIQUE NOT NULL,
  amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
  currency VARCHAR(10) DEFAULT 'EUR' CHECK (currency IN ('EUR','USD','GBP')),
  issued_at TIMESTAMPTZ DEFAULT NOW(),
  paid_at TIMESTAMPTZ,
  due_date TIMESTAMPTZ,
  status VARCHAR(50) DEFAULT 'PENDING' CHECK (status IN ('PENDING','PAID','OVERDUE')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_invoices_order ON invoices(order_id);
CREATE INDEX IF NOT EXISTS idx_invoices_status ON invoices(status);

-- Paiements effectués sur une facture
CREATE TABLE IF NOT EXISTS payments (
  id SERIAL PRIMARY KEY,
  invoice_id INT NOT NULL REFERENCES invoices(id) ON DELETE CASCADE,
  payment_method VARCHAR(50) CHECK (payment_method IN ('CARD','BANK_TRANSFER','CASH')),
  amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
  paid_at TIMESTAMPTZ DEFAULT NOW(),
  note TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_payments_invoice ON payments(invoice_id);

-- Maintenance des camions (historique des révisions, réparations)
CREATE TABLE IF NOT EXISTS truck_maintenances (
  id SERIAL PRIMARY KEY,
  truck_id INT NOT NULL REFERENCES trucks(id) ON DELETE CASCADE,
  maintenance_date TIMESTAMPTZ DEFAULT NOW(),
  description TEXT,
  cost DECIMAL(10,2) NOT NULL CHECK (cost >= 0),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_truck_maintenances_truck ON truck_maintenances(truck_id);

-- Table pour stocker des KPI calculés périodiquement (journaliers, hebdomadaires)
CREATE TABLE IF NOT EXISTS kpi_snapshots (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  period_start DATE NOT NULL,
  period_end DATE NOT NULL,
  total_orders INT CHECK (total_orders >= 0),
  on_time_deliveries INT CHECK (on_time_deliveries >= 0),
  late_deliveries INT CHECK (late_deliveries >= 0),
  total_revenue DECIMAL(10,2) CHECK (total_revenue >= 0),
  total_costs DECIMAL(10,2) CHECK (total_costs >= 0),
  created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_kpi_snapshots_company ON kpi_snapshots(company_id);

-- Notifications internes (par exemple : stock faible, facture en retard, etc.)
CREATE TABLE IF NOT EXISTS notifications (
  id SERIAL PRIMARY KEY,
  company_id INT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  user_id INT REFERENCES users(id) ON DELETE SET NULL,
  notification_type VARCHAR(50), 
  message TEXT,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ,
  deleted_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS idx_notifications_company ON notifications(company_id);

COMMIT;
