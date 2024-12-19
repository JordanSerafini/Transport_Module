BEGIN;

-- ==============================================
-- Insertion des unités de mesure
-- ==============================================
INSERT INTO unit (code, label) VALUES
('kg', 'Kilogramme'),
('g', 'Gramme'),
('lb', 'Livre'),
('oz', 'Once');

-- ==============================================
-- Insertion des adresses
-- ==============================================
INSERT INTO address (street, city, state, country, postal_code, latitude, longitude) VALUES
('123 Rue de la Paix', 'Paris', 'Île-de-France', 'France', '75001', 48.8566, 2.3522),
('456 Avenue des Champs', 'Lyon', 'Auvergne-Rhône-Alpes', 'France', '69001', 45.7640, 4.8357),
('789 Boulevard Saint-Germain', 'Marseille', 'Provence-Alpes-Côte d\'Azur', 'France', '13001', 43.2965, 5.3698),
('321 Rue Nationale', 'Toulouse', 'Occitanie', 'France', '31000', 43.6047, 1.4442),
('654 Avenue de la Liberté', 'Nice', 'Provence-Alpes-Côte d\'Azur', 'France', '06000', 43.7102, 7.2620),
('987 Rue Victor Hugo', 'Bordeaux', 'Nouvelle-Aquitaine', 'France', '33000', 44.8378, -0.5792),
('159 Boulevard de la République', 'Lille', 'Hauts-de-France', 'France', '59000', 50.6292, 3.0573),
('753 Rue de l\'Industrie', 'Nantes', 'Pays de la Loire', 'France', '44000', 47.2184, -1.5536),
('852 Avenue de la Gare', 'Strasbourg', 'Grand Est', 'France', '67000', 48.5734, 7.7521),
('951 Rue du Commerce', 'Montpellier', 'Occitanie', 'France', '34000', 43.6108, 3.8767);

-- ==============================================
-- Insertion des entreprises (companies)
-- ==============================================
INSERT INTO company (name, email, phone, address_id, timezone) VALUES
('LogiTrans France', 'contact@logitrans.fr', '+33 1 23 45 67 89', 1, 'Europe/Paris'),
('TransExpress', 'info@transexpress.fr', '+33 2 34 56 78 90', 2, 'Europe/Paris'),
('FastMove', 'support@fastmove.fr', '+33 3 45 67 89 01', 3, 'Europe/Paris');

-- Récupération des IDs des entreprises
WITH company_ids AS (
    SELECT id, name FROM company
)
SELECT * FROM company_ids; -- Pour vérification, peut être supprimé

-- ==============================================
-- Insertion des clients (customers)
-- ==============================================
INSERT INTO customer (company_id, name, email, phone, address_id) VALUES
(1, 'Société Alpha', 'alpha@client.fr', '+33 4 56 78 90 12', 4),
(1, 'Société Beta', 'beta@client.fr', '+33 5 67 89 01 23', 5),
(2, 'Entreprise Gamma', 'gamma@client.fr', '+33 6 78 90 12 34', 6),
(2, 'Entreprise Delta', 'delta@client.fr', '+33 7 89 01 23 45', 7),
(3, 'Startup Epsilon', 'epsilon@client.fr', '+33 8 90 12 34 56', 8),
(3, 'Startup Zeta', 'zeta@client.fr', '+33 9 01 23 45 67', 9);

-- ==============================================
-- Insertion des entrepôts (warehouses)
-- ==============================================
INSERT INTO warehouse (company_id, name, address_id, capacity, warehouse_type) VALUES
(1, 'Entrepôt Principal Paris', 1, 10000, 'MAIN'),
(1, 'Entrepôt Lyon', 2, 5000, 'SECONDARY'),
(2, 'Entrepôt Marseille', 3, 8000, 'MAIN'),
(2, 'Entrepôt Toulouse', 4, 6000, 'HUB'),
(3, 'Entrepôt Nice', 5, 7000, 'MAIN'),
(3, 'Entrepôt Bordeaux', 6, 5500, 'SECONDARY');

-- ==============================================
-- Insertion des camions (trucks)
-- ==============================================
INSERT INTO truck (company_id, license_plate, capacity, model) VALUES
(1, 'AB-123-CD', 2000, 'Volvo FH'),
(1, 'EF-456-GH', 1500, 'Scania R-Series'),
(1, 'IJ-789-KL', 1800, 'Mercedes Actros'),
(2, 'MN-012-OP', 2200, 'DAF XF'),
(2, 'QR-345-ST', 1600, 'Iveco Stralis'),
(3, 'UV-678-WX', 1700, 'MAN TGX'),
(3, 'YZ-901-AB', 2100, 'Renault T Series'),
(3, 'CD-234-EF', 1900, 'Ford Cargo');

-- ==============================================
-- Insertion des chauffeurs (drivers)
-- ==============================================
INSERT INTO driver (company_id, name, license_number, license_expiry_date, phone, driver_status) VALUES
(1, 'Jean Dupont', 'DUPJ123456', '2025-12-31', '+33 6 12 34 56 78', 'ACTIVE'),
(1, 'Marie Curie', 'CURM654321', '2024-06-30', '+33 6 87 65 43 21', 'ACTIVE'),
(1, 'Pierre Martin', 'MARP112233', '2026-03-15', '+33 6 23 45 67 89', 'SUSPENDED'),
(2, 'Lucie Moreau', 'MORE445566', '2025-09-10', '+33 6 34 56 78 90', 'ACTIVE'),
(2, 'Sophie Laurent', 'LAUS778899', '2023-11-20', '+33 6 45 67 89 01', 'INACTIVE'),
(3, 'Thomas Bernard', 'BERT998877', '2024-02-28', '+33 6 56 78 90 12', 'ACTIVE'),
(3, 'Emma Petit', 'PETE665544', '2025-07-22', '+33 6 67 89 01 23', 'ACTIVE'),
(3, 'Lucas Lefevre', 'LEFL334455', '2026-01-05', '+33 6 78 90 12 34', 'ACTIVE');

-- ==============================================
-- Insertion des produits (products)
-- ==============================================
INSERT INTO product (company_id, name, weight, unit_id, description) VALUES
(1, 'Boîtes en carton', 1, 1, 'Boîtes standard pour expédition'),
(1, 'Palette en bois', 20, 1, 'Palette de 120x80 cm en bois'),
(1, 'Sacs plastiques', 0.5, 2, 'Sacs réutilisables en plastique'),
(2, 'Conteneur réfrigéré', 100, 1, 'Conteneur pour produits périssables'),
(2, 'Bouteilles en verre', 0.75, 2, 'Bouteilles de différentes tailles'),
(3, 'Machines industrielles', 500, 1, 'Équipements lourds pour la production'),
(3, 'Composants électroniques', 0.2, 2, 'Petits composants pour appareils électroniques'),
(3, 'Papiers d\'emballage', 0.1, 2, 'Papier bulle et papier kraft');

-- ==============================================
-- Insertion des statuts de commandes (order_status)
-- ==============================================
INSERT INTO order_status (code, label, is_final) VALUES
('PENDING', 'En attente', FALSE),
('PREPARING', 'En préparation', FALSE),
('SHIPPED', 'Expédiée', FALSE),
('DELIVERED', 'Livrée', TRUE),
('CANCELLED', 'Annulée', TRUE);

-- ==============================================
-- Insertion des statuts d'expédition (shipment_status)
-- ==============================================
INSERT INTO shipment_status (code, label, is_final) VALUES
('PREPARED', 'Préparée', FALSE),
('IN_TRANSIT', 'En transit', FALSE),
('DELIVERED', 'Livrée', TRUE),
('RETURNED', 'Retour', TRUE);

-- ==============================================
-- Insertion des utilisateurs internes (users)
-- ==============================================
INSERT INTO "user" (company_id, email, password_hash, name, role) VALUES
(1, 'admin@logitrans.fr', 'hashed_password_1', 'Admin LogiTrans', 'ADMIN'),
(1, 'manager1@logitrans.fr', 'hashed_password_2', 'Manager LogiTrans 1', 'MANAGER'),
(1, 'user1@logitrans.fr', 'hashed_password_3', 'Utilisateur LogiTrans 1', 'USER'),
(2, 'admin@transexpress.fr', 'hashed_password_4', 'Admin TransExpress', 'ADMIN'),
(2, 'manager2@transexpress.fr', 'hashed_password_5', 'Manager TransExpress 1', 'MANAGER'),
(2, 'user2@transexpress.fr', 'hashed_password_6', 'Utilisateur TransExpress 1', 'USER'),
(3, 'admin@fastmove.fr', 'hashed_password_7', 'Admin FastMove', 'ADMIN'),
(3, 'manager3@fastmove.fr', 'hashed_password_8', 'Manager FastMove 1', 'MANAGER'),
(3, 'user3@fastmove.fr', 'hashed_password_9', 'Utilisateur FastMove 1', 'USER');

-- ==============================================
-- Insertion des commandes (orders)
-- ==============================================
INSERT INTO "order" (company_id, customer_id, warehouse_id, total_weight, status_id) VALUES
(1, 1, 1, 500, 1),
(1, 2, 2, 1200, 2),
(2, 3, 3, 800, 3),
(2, 4, 4, 1500, 1),
(3, 5, 5, 300, 4),
(3, 6, 6, 1000, 5);

-- ==============================================
-- Insertion des détails de commandes (order_items)
-- ==============================================
INSERT INTO order_item (order_id, product_id, quantity, unit_weight) VALUES
(1, 1, 100, 1),
(1, 2, 50, 20),
(2, 3, 200, 0.5),
(2, 4, 10, 100),
(3, 5, 150, 0.75),
(4, 6, 5, 500),
(4, 7, 300, 0.2),
(5, 8, 500, 0.1),
(6, 1, 200, 1),
(6, 3, 100, 0.5);

-- ==============================================
-- Insertion des routes (routes)
-- ==============================================
INSERT INTO route (company_id, name, start_warehouse_id, end_warehouse_id) VALUES
(1, 'Route Paris-Lyon', 1, 2),
(1, 'Route Paris-Marseille', 1, 3),
(2, 'Route Marseille-Toulouse', 3, 4),
(2, 'Route Toulouse-Nice', 4, 5),
(3, 'Route Nice-Bordeaux', 5, 6),
(3, 'Route Bordeaux-Lille', 6, 7);

-- ==============================================
-- Insertion des arrêts de routes (route_stops)
-- ==============================================
-- Exemple pour la première route
INSERT INTO route_stop (route_id, warehouse_id, stop_order, stop_type, arrival_eta, departure_eta) VALUES
(1, 2, 1, 'WAREHOUSE', '2024-01-10 09:00:00', '2024-01-10 09:30:00'),
(1, 3, 2, 'WAREHOUSE', '2024-01-10 12:00:00', '2024-01-10 12:30:00');

-- Exemple pour la deuxième route
INSERT INTO route_stop (route_id, warehouse_id, stop_order, stop_type, arrival_eta, departure_eta) VALUES
(2, 3, 1, 'WAREHOUSE', '2024-01-11 08:00:00', '2024-01-11 08:45:00'),
(2, 4, 2, 'WAREHOUSE', '2024-01-11 11:00:00', '2024-01-11 11:30:00');

-- Répéter pour les autres routes...
-- Pour brevité, voici quelques exemples supplémentaires
INSERT INTO route_stop (route_id, warehouse_id, stop_order, stop_type, arrival_eta, departure_eta) VALUES
(3, 4, 1, 'WAREHOUSE', '2024-01-12 07:00:00', '2024-01-12 07:30:00'),
(3, 5, 2, 'WAREHOUSE', '2024-01-12 10:00:00', '2024-01-12 10:30:00'),
(4, 5, 1, 'WAREHOUSE', '2024-01-13 09:00:00', '2024-01-13 09:30:00'),
(4, 6, 2, 'WAREHOUSE', '2024-01-13 12:00:00', '2024-01-13 12:30:00'),
(5, 6, 1, 'WAREHOUSE', '2024-01-14 08:30:00', '2024-01-14 09:00:00'),
(5, 7, 2, 'WAREHOUSE', '2024-01-14 11:30:00', '2024-01-14 12:00:00'),
(6, 7, 1, 'WAREHOUSE', '2024-01-15 07:30:00', '2024-01-15 08:00:00'),
(6, 1, 2, 'WAREHOUSE', '2024-01-15 10:30:00', '2024-01-15 11:00:00');

-- ==============================================
-- Insertion des expéditions (shipments)
-- ==============================================
INSERT INTO shipment (order_id, truck_id, driver_id, route_id, status_id) VALUES
(1, 1, 1, 1, 1),
(2, 2, 2, 2, 2),
(3, 3, 3, 3, 3),
(4, 4, 4, 4, 1),
(5, 5, 5, 5, 4),
(6, 6, 6, 6, 5),
(1, 7, 7, 1, 2),
(2, 8, 8, 2, 3),
(3, 1, 1, 3, 1),
(4, 2, 2, 4, 2),
(5, 3, 3, 5, 3),
(6, 4, 4, 6, 4);

-- ==============================================
-- Insertion des événements d'expédition (shipment_events)
-- ==============================================
INSERT INTO shipment_event (shipment_id, event_status_id, event_time, comment) VALUES
(1, 1, '2024-01-10 08:00:00', 'Commande préparée'),
(1, 2, '2024-01-10 09:00:00', 'Départ de l\'entrepôt principal'),
(1, 3, '2024-01-10 12:00:00', 'En transit'),
(1, 4, '2024-01-10 15:00:00', 'Livraison effectuée'),
(2, 1, '2024-01-11 07:00:00', 'Commande en attente'),
(2, 2, '2024-01-11 08:00:00', 'Départ de l\'entrepôt Lyon'),
(2, 3, '2024-01-11 11:00:00', 'En transit'),
(2, 5, '2024-01-11 14:00:00', 'Commande annulée'),
(3, 1, '2024-01-12 06:30:00', 'Commande préparée'),
(3, 2, '2024-01-12 07:30:00', 'Départ de l\'entrepôt Marseille'),
(3, 4, '2024-01-12 10:00:00', 'Livraison annulée'),
-- Ajouter plus d'événements pour d'autres expéditions
(4, 1, '2024-01-13 08:00:00', 'Commande en attente'),
(4, 2, '2024-01-13 09:00:00', 'Départ de l\'entrepôt Toulouse'),
(4, 3, '2024-01-13 12:00:00', 'En transit'),
(4, 4, '2024-01-13 15:00:00', 'Livraison effectuée'),
(5, 1, '2024-01-14 07:30:00', 'Commande en attente'),
(5, 2, '2024-01-14 09:30:00', 'Départ de l\'entrepôt Nice'),
(5, 3, '2024-01-14 12:30:00', 'En transit'),
(5, 4, '2024-01-14 16:00:00', 'Livraison effectuée'),
(6, 1, '2024-01-15 07:00:00', 'Commande en attente'),
(6, 2, '2024-01-15 08:00:00', 'Départ de l\'entrepôt Bordeaux'),
(6, 3, '2024-01-15 11:00:00', 'En transit'),
(6, 4, '2024-01-15 14:00:00', 'Livraison effectuée');

-- ==============================================
-- Insertion des factures (invoices)
-- ==============================================
INSERT INTO invoice (order_id, invoice_number, amount, currency, issued_at, due_date, status) VALUES
(1, 'INV-1001', 1500.00, 'EUR', '2024-01-10 10:00:00', '2024-02-10 10:00:00', 'PENDING'),
(2, 'INV-1002', 3000.00, 'EUR', '2024-01-11 12:00:00', '2024-02-11 12:00:00', 'PAID'),
(3, 'INV-1003', 2500.00, 'EUR', '2024-01-12 14:00:00', '2024-02-12 14:00:00', 'OVERDUE'),
(4, 'INV-1004', 4000.00, 'EUR', '2024-01-13 16:00:00', '2024-02-13 16:00:00', 'PENDING'),
(5, 'INV-1005', 500.00, 'EUR', '2024-01-14 18:00:00', '2024-02-14 18:00:00', 'PAID'),
(6, 'INV-1006', 3500.00, 'EUR', '2024-01-15 20:00:00', '2024-02-15 20:00:00', 'PENDING');

-- ==============================================
-- Insertion des paiements (payments)
-- ==============================================
INSERT INTO payment (invoice_id, payment_method, amount, paid_at, note) VALUES
(2, 'BANK_TRANSFER', 3000.00, '2024-01-20 10:00:00', 'Paiement complet'),
(5, 'CASH', 500.00, '2024-01-25 14:00:00', 'Paiement en espèces');

-- ==============================================
-- Insertion des maintenances des camions (truck_maintenance)
-- ==============================================
INSERT INTO truck_maintenance (truck_id, maintenance_date, description, cost) VALUES
(1, '2024-01-05 10:00:00', 'Changement des pneus', 800.00),
(2, '2024-01-07 12:00:00', 'Révision moteur', 1200.00),
(3, '2024-01-10 09:30:00', 'Remplacement des freins', 600.00),
(4, '2024-01-12 15:45:00', 'Entretien général', 700.00),
(5, '2024-01-14 11:20:00', 'Diagnostic électronique', 500.00),
(6, '2024-01-16 14:50:00', 'Nettoyage complet', 300.00),
(7, '2024-01-18 08:10:00', 'Réparation du système de refroidissement', 900.00),
(8, '2024-01-20 16:30:00', 'Mise à jour logicielle', 400.00);

-- ==============================================
-- Insertion des KPI (kpi_snapshot)
-- ==============================================
INSERT INTO kpi_snapshot (company_id, period_start, period_end, total_orders, on_time_deliveries, late_deliveries, total_revenue, total_costs) VALUES
(1, '2024-01-01', '2024-01-31', 50, 45, 5, 75000.00, 50000.00),
(2, '2024-01-01', '2024-01-31', 60, 50, 10, 90000.00, 60000.00),
(3, '2024-01-01', '2024-01-31', 40, 35, 5, 60000.00, 40000.00);

-- ==============================================
-- Insertion des notifications (notifications)
-- ==============================================
INSERT INTO notification (company_id, user_id, notification_type, message, is_read) VALUES
(1, 1, 'STOCK_ALERT', 'Stock de "Boîtes en carton" inférieur à 100 unités.', FALSE),
(1, 2, 'DELIVERY_DELAY', 'Livraison INV-1001 en retard.', FALSE),
(2, 4, 'PAYMENT_OVERDUE', 'Facture INV-1003 est en retard de paiement.', FALSE),
(3, 7, 'MAINTENANCE_SCHEDULED', 'Maintenance prévue pour le camion UV-678-WX le 2024-02-20.', FALSE),
(3, 8, 'STOCK_ALERT', 'Stock de "Composants électroniques" inférieur à 50 unités.', FALSE),
(1, 3, 'DELIVERY_DELAY', 'Livraison INV-1004 en retard.', TRUE),
(2, 5, 'STOCK_ALERT', 'Stock de "Conteneur réfrigéré" inférieur à 10 unités.', FALSE),
(3, 9, 'PAYMENT_OVERDUE', 'Facture INV-1006 est en retard de paiement.', FALSE);

-- ==============================================
-- Insertion des événements d'expédition supplémentaires
-- ==============================================
-- Ajout d'événements pour d'autres expéditions
INSERT INTO shipment_event (shipment_id, event_status_id, event_time, comment) VALUES
(2, 1, '2024-01-11 07:00:00', 'Commande en attente'),
(2, 2, '2024-01-11 08:00:00', 'Départ de l\'entrepôt Lyon'),
(2, 3, '2024-01-11 11:00:00', 'En transit'),
(2, 3, '2024-01-11 13:00:00', 'Arrêt pour ravitaillement'),
(2, 3, '2024-01-11 14:00:00', 'Retour à l\'entrepôt'),
(3, 1, '2024-01-12 06:30:00', 'Commande préparée'),
(3, 2, '2024-01-12 07:30:00', 'Départ de l\'entrepôt Marseille'),
(3, 3, '2024-01-12 10:00:00', 'En transit'),
(3, 3, '2024-01-12 12:00:00', 'Arrêt pour inspection'),
(3, 4, '2024-01-12 15:00:00', 'Livraison effectuée');

-- ==============================================
-- Insertion des stocks (inventory)
-- ==============================================
INSERT INTO inventory (warehouse_id, product_id, quantity) VALUES
(1, 1, 1000),
(1, 2, 500),
(1, 3, 2000),
(2, 4, 300),
(2, 5, 1500),
(3, 6, 50),
(3, 7, 3000),
(4, 8, 5000),
(5, 1, 800),
(5, 3, 2500),
(6, 2, 400),
(6, 4, 600);

COMMIT;
