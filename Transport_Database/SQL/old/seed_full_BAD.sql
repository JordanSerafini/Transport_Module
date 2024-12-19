BEGIN;

-- ==================================================
--               Tables de Référence
-- ==================================================

-- Unités de mesure (pour gérer le poids des produits)
INSERT INTO units (id, code, label, created_at, updated_at) VALUES
  (1, 'KG', 'Kilogramme', NOW(), NOW()),
  (2, 'LB', 'Livre', NOW(), NOW()),
  (3, 'PCS', 'Pièces', NOW(), NOW());

-- Statuts de Commande
INSERT INTO order_statuses (id, code, label, is_final) VALUES
  (1, 'CREATED', 'Commande créée', FALSE),
  (2, 'PROCESSING', 'Commande en traitement', FALSE),
  (3, 'SHIPPED', 'Commande expédiée', FALSE),
  (4, 'DELIVERED', 'Commande livrée', TRUE),
  (5, 'CANCELED', 'Commande annulée', TRUE),
  (6, 'RETURNED', 'Commande retournée', TRUE),
  (7, 'ON_HOLD', 'Commande en attente', FALSE),
  (8, 'PARTIALLY_DELIVERED', 'Commande partiellement livrée', FALSE),
  (9, 'BACKORDERED', 'Commande en rupture de stock', FALSE),
  (10, 'FAILED', 'Commande échouée', TRUE);

-- Statuts d'Expédition
INSERT INTO shipment_statuses (id, code, label, is_final) VALUES
  (1, 'PENDING_PICKUP', 'En attente de ramassage', FALSE),
  (2, 'IN_TRANSIT', 'En transit', FALSE),
  (3, 'OUT_FOR_DELIVERY', 'En cours de livraison', FALSE),
  (4, 'DELIVERED', 'Livré', TRUE),
  (5, 'RETURNED', 'Retourné', TRUE),
  (6, 'CANCELED', 'Expédition annulée', TRUE),
  (7, 'DAMAGED', 'Expédition endommagée', TRUE),
  (8, 'DELAYED', 'Expédition retardée', FALSE),
  (9, 'ON_ROUTE', 'Expédition en route', FALSE),
  (10, 'RE_ROUTED', 'Expédition réacheminée', FALSE);

-- ==================================================
--               Entreprise et Adresses
-- ==================================================

-- Adresse principale de l'entreprise
INSERT INTO addresses (id, street, city, state, country, postal_code, latitude, longitude, created_at, updated_at, deleted_at) VALUES
  (1, '45 Avenue des Champs-Élysées', 'Paris', 'Île-de-France', 'France', '75008', 48.8698, 2.3078, NOW(), NOW(), NULL);

-- Entreprise (tenant)
INSERT INTO companies (id, name, email, phone, address_id, timezone, created_at, updated_at, deleted_at) VALUES
  (1, 'LogiPro Solutions', 'contact@logipro.com', '+33-1-23-45-67-89', 1, 'Europe/Paris', NOW(), NOW(), NULL);

-- Autres adresses (clients, entrepôts, etc.)
INSERT INTO addresses (id, street, city, state, country, postal_code, latitude, longitude, created_at, updated_at, deleted_at) VALUES
  -- Clients
  (2, '12 Rue de Rivoli', 'Paris', 'Île-de-France', 'France', '75004', 48.8566, 2.3522, NOW(), NOW(), NULL),
  (3, '34 Boulevard Saint-Germain', 'Paris', 'Île-de-France', 'France', '75005', 48.8499, 2.3412, NOW(), NOW(), NULL),
  (4, '56 Rue de la Paix', 'Paris', 'Île-de-France', 'France', '75002', 48.8693, 2.3290, NOW(), NOW(), NULL),
  (5, '78 Avenue de l Opéra', 'Paris', 'Île-de-France', 'France', '75001', 48.8700, 2.3310, NOW(), NOW(), NULL),
  (6, '90 Rue Montorgueil', 'Paris', 'Île-de-France', 'France', '75002', 48.8662, 2.3524, NOW(), NOW(), NULL),
  (7, '123 Boulevard Haussmann', 'Paris', 'Île-de-France', 'France', '75009', 48.8756, 2.3313, NOW(), NOW(), NULL),
  (8, '456 Rue de la République', 'Lyon', 'Auvergne-Rhône-Alpes', 'France', '69003', 45.7580, 4.8320, NOW(), NOW(), NULL),
  (9, '789 Avenue Jean Jaurès', 'Marseille', 'Provence-Alpes-Côte d Azur', 'France', '13001', 43.2965, 5.3698, NOW(), NOW(), NULL),
  (10, '101 Rue Foch', 'Toulouse', 'Occitanie', 'France', '31000', 43.6047, 1.4442, NOW(), NOW(), NULL),

  -- Entrepôts
  (11, '22 Rue des Entrepôts', 'Paris', 'Île-de-France', 'France', '75010', 48.8722, 2.3599, NOW(), NOW(), NULL),
  (12, '33 Rue de la Logistique', 'Lyon', 'Auvergne-Rhône-Alpes', 'France', '69008', 45.7640, 4.8357, NOW(), NOW(), NULL),
  (13, '44 Rue de l Expédition', 'Marseille', 'Provence-Alpes-Côte d Azur', 'France', '13008', 43.2961, 5.3723, NOW(), NOW(), NULL),
  (14, '55 Rue de Stockage', 'Toulouse', 'Occitanie', 'France', '31000', 43.6043, 1.4440, NOW(), NOW(), NULL),

  -- Autres adresses diverses
  (15, '66 Rue des Arts', 'Nice', 'Provence-Alpes-Côte d Azur', 'France', '06000', 43.7102, 7.2620, NOW(), NOW(), NULL),
  (16, '77 Rue des Vignerons', 'Bordeaux', 'Nouvelle-Aquitaine', 'France', '33000', 44.8378, -0.5792, NOW(), NOW(), NULL),
  (17, '88 Rue de la Gare', 'Lille', 'Hauts-de-France', 'France', '59000', 50.6292, 3.0573, NOW(), NOW(), NULL),
  (18, '99 Rue des Fleurs', 'Strasbourg', 'Grand Est', 'France', '67000', 48.5734, 7.7521, NOW(), NOW(), NULL),
  (19, '110 Rue des Écoles', 'Nantes', 'Pays de la Loire', 'France', '44000', 47.2184, -1.5536, NOW(), NOW(), NULL),
  (20, '121 Rue de la Liberté', 'Montpellier', 'Occitanie', 'France', '34000', 43.6108, 3.8767, NOW(), NOW(), NULL);

-- ==================================================
--                      Clients
-- ==================================================

INSERT INTO customers (id, company_id, name, email, phone, address_id, created_at, updated_at, deleted_at) VALUES
  (1, 1, 'Marie Dupont', 'marie.dupont@example.com', '+33-6-12-34-56-78', 2, NOW(), NOW(), NULL),
  (2, 1, 'Jean Martin', 'jean.martin@example.com', '+33-6-23-45-67-89', 3, NOW(), NOW(), NULL),
  (3, 1, 'Sophie Bernard', 'sophie.bernard@example.com', '+33-6-34-56-78-90', 4, NOW(), NOW(), NULL),
  (4, 1, 'Pierre Dubois', 'pierre.dubois@example.com', '+33-6-45-67-89-01', 5, NOW(), NOW(), NULL),
  (5, 1, 'Nathalie Lefevre', 'nathalie.lefevre@example.com', '+33-6-56-78-90-12', 6, NOW(), NOW(), NULL),
  (6, 1, 'Laurent Moreau', 'laurent.moreau@example.com', '+33-6-67-89-01-23', 7, NOW(), NOW(), NULL),
  (7, 1, 'Isabelle Petit', 'isabelle.petit@example.com', '+33-6-78-90-12-34', 8, NOW(), NOW(), NULL),
  (8, 1, 'François Roux', 'francois.roux@example.com', '+33-6-89-01-23-45', 9, NOW(), NOW(), NULL),
  (9, 1, 'Cécile Garnier', 'cecile.garnier@example.com', '+33-6-90-12-34-56', 10, NOW(), NOW(), NULL),
  (10, 1, 'Thomas Garcia', 'thomas.garcia@example.com', '+33-6-01-23-45-67', 2, NOW(), NOW(), NULL),
  
  -- Clients 11 à 100
  (11, 1, 'Élodie Lopez', 'elodie.lopez@example.com', '+33-6-12-34-56-79', 3, NOW(), NOW(), NULL),
  (12, 1, 'Antoine Sanchez', 'antoine.sanchez@example.com', '+33-6-23-45-67-80', 4, NOW(), NOW(), NULL),
  (13, 1, 'Camille Nguyen', 'camille.nguyen@example.com', '+33-6-34-56-78-91', 5, NOW(), NOW(), NULL),
  (14, 1, 'Maxime Laurent', 'maxime.laurent@example.com', '+33-6-45-67-89-02', 6, NOW(), NOW(), NULL),
  (15, 1, 'Julie Fournier', 'julie.fournier@example.com', '+33-6-56-78-90-13', 7, NOW(), NOW(), NULL),
  (16, 1, 'Benjamin Mercier', 'benjamin.mercier@example.com', '+33-6-67-89-01-24', 8, NOW(), NOW(), NULL),
  (17, 1, 'Aurélie Bonnet', 'aurelie.bonnet@example.com', '+33-6-78-90-12-35', 9, NOW(), NOW(), NULL),
  (18, 1, 'Mathieu Fontaine', 'mathieu.fontaine@example.com', '+33-6-89-01-23-46', 10, NOW(), NOW(), NULL),
  (19, 1, 'Caroline Rousseau', 'caroline.rousseau@example.com', '+33-6-90-12-34-57', 2, NOW(), NOW(), NULL),
  (20, 1, 'Vincent Masson', 'vincent.masson@example.com', '+33-6-01-23-45-68', 3, NOW(), NOW(), NULL),
  
  (21, 1, 'Laura Dupuis', 'laura.dupuis@example.com', '+33-6-12-34-56-79', 4, NOW(), NOW(), NULL),
  (22, 1, 'Gilles Renault', 'gilles.renault@example.com', '+33-6-23-45-67-80', 5, NOW(), NOW(), NULL),
  (23, 1, 'Elise Girard', 'elise.girard@example.com', '+33-6-34-56-78-91', 6, NOW(), NOW(), NULL),
  (24, 1, 'Lucas Lefevre', 'lucas.lefevre@example.com', '+33-6-45-67-89-02', 7, NOW(), NOW(), NULL),
  (25, 1, 'Clara Dubois', 'clara.dubois@example.com', '+33-6-56-78-90-13', 8, NOW(), NOW(), NULL),
  (26, 1, 'Romain Morel', 'romain.morel@example.com', '+33-6-67-89-01-24', 9, NOW(), NOW(), NULL),
  (27, 1, 'Mélanie Marchand', 'melanie.marchand@example.com', '+33-6-78-90-12-35', 10, NOW(), NOW(), NULL),
  (28, 1, 'Simon Blanc', 'simon.blanc@example.com', '+33-6-89-01-23-46', 2, NOW(), NOW(), NULL),
  (29, 1, 'Hélène Lefebvre', 'helene.lefebvre@example.com', '+33-6-90-12-34-57', 3, NOW(), NOW(), NULL),
  (30, 1, 'Alexandre Lambert', 'alexandre.lambert@example.com', '+33-6-01-23-45-68', 4, NOW(), NOW(), NULL),
  
  -- Clients 31 à 100
  (31, 1, 'Sébastien Rouillard', 'sebastien.rouillard@example.com', '+33-6-90-12-34-99', 10, NOW(), NOW(), NULL),
  (32, 1, 'Isabelle Bernard', 'isabelle.bernard@example.com', '+33-6-02-34-56-78', 5, NOW(), NOW(), NULL),
  (33, 1, 'David Caron', 'david.caron@example.com', '+33-6-03-45-67-89', 6, NOW(), NOW(), NULL),
  (34, 1, 'Emma Vidal', 'emma.vidal@example.com', '+33-6-04-56-78-90', 7, NOW(), NOW(), NULL),
  (35, 1, 'Nicolas Perrot', 'nicolas.perrot@example.com', '+33-6-05-67-89-01', 8, NOW(), NOW(), NULL),
  (36, 1, 'Julie Martin', 'julie.martin@example.com', '+33-6-06-78-90-12', 9, NOW(), NOW(), NULL),
  (37, 1, 'Pierre Thomas', 'pierre.thomas@example.com', '+33-6-07-89-01-23', 10, NOW(), NOW(), NULL),
  (38, 1, 'Claire Dupont', 'claire.dupont@example.com', '+33-6-08-90-12-34', 2, NOW(), NOW(), NULL),
  (39, 1, 'Lucas Renault', 'lucas.renault@example.com', '+33-6-09-01-23-45', 3, NOW(), NOW(), NULL),
  (40, 1, 'Chloé Dubois', 'chloe.dubois@example.com', '+33-6-10-12-34-56', 4, NOW(), NOW(), NULL),
  
  (41, 1, 'Maxime Leclerc', 'maxime.leclerc@example.com', '+33-6-11-23-45-67', 5, NOW(), NOW(), NULL),
  (42, 1, 'Élise Fournier', 'elise.fournier@example.com', '+33-6-12-34-56-78', 6, NOW(), NOW(), NULL),
  (43, 1, 'Adrien Marchal', 'adrien.marchal@example.com', '+33-6-13-45-67-89', 7, NOW(), NOW(), NULL),
  (44, 1, 'Laura Picard', 'laura.picard@example.com', '+33-6-14-56-78-90', 8, NOW(), NOW(), NULL),
  (45, 1, 'Thomas Blanchard', 'thomas.blanchard@example.com', '+33-6-15-67-89-01', 9, NOW(), NOW(), NULL),
  (46, 1, 'Marie Chevalier', 'marie.chevalier@example.com', '+33-6-16-78-90-12', 10, NOW(), NOW(), NULL),
  (47, 1, 'Victor Fontaine', 'victor.fontaine@example.com', '+33-6-17-89-01-23', 2, NOW(), NOW(), NULL),
  (48, 1, 'Clara Noel', 'clara.noel@example.com', '+33-6-18-90-12-34', 3, NOW(), NOW(), NULL),
  (49, 1, 'Gabriel Girard', 'gabriel.girard@example.com', '+33-6-19-01-23-45', 4, NOW(), NOW(), NULL),
  (50, 1, 'Sophie Lefebvre', 'sophie.lefebvre@example.com', '+33-6-20-12-34-56', 5, NOW(), NOW(), NULL),

  -- Clients 51 à 100 (exemples supplémentaires)
  (51, 1, 'Mathieu Lambert', 'mathieu.lambert@example.com', '+33-6-21-23-45-67', 6, NOW(), NOW(), NULL),
  (52, 1, 'Julie Roux', 'julie.roux@example.com', '+33-6-22-34-56-78', 7, NOW(), NOW(), NULL),
  (53, 1, 'Antoine Martin', 'antoine.martin@example.com', '+33-6-23-45-67-89', 8, NOW(), NOW(), NULL),
  (54, 1, 'Emma Moreau', 'emma.moreau@example.com', '+33-6-24-56-78-90', 9, NOW(), NOW(), NULL),
  (55, 1, 'Nathan Bernard', 'nathan.bernard@example.com', '+33-6-25-67-89-01', 10, NOW(), NOW(), NULL),
  (56, 1, 'Clara Petit', 'clara.petit@example.com', '+33-6-26-78-90-12', 2, NOW(), NOW(), NULL),
  (57, 1, 'Lucas Dubois', 'lucas.dubois@example.com', '+33-6-27-89-01-23', 3, NOW(), NOW(), NULL),
  (58, 1, 'Camille Rousseau', 'camille.rousseau@example.com', '+33-6-28-90-12-34', 4, NOW(), NOW(), NULL),
  (59, 1, 'Paul Garcia', 'paul.garcia@example.com', '+33-6-29-01-23-45', 5, NOW(), NOW(), NULL),
  (60, 1, 'Laura Lefebvre', 'laura.lefebvre@example.com', '+33-6-30-12-34-56', 6, NOW(), NOW(), NULL),

  -- ... (Continuez jusqu'à 100 clients en suivant le même schéma)
  -- Exemple :
  (61, 1, 'Sébastien Dupont', 'sebastien.dupont@example.com', '+33-6-31-23-45-67', 7, NOW(), NOW(), NULL),
  (62, 1, 'Élodie Martin', 'elodie.martin@example.com', '+33-6-32-34-56-78', 8, NOW(), NOW(), NULL),
  -- ...
  (100, 1, 'Sébastien Rouillard', 'sebastien.rouillard@example.com', '+33-6-90-12-34-99', 10, NOW(), NOW(), NULL);

-- ==================================================
--                     Entrepôts
-- ==================================================

INSERT INTO warehouses (id, company_id, name, address_id, capacity, warehouse_type, created_at, updated_at, deleted_at) VALUES
  (1, 1, 'Entrepôt Principal', 11, 50000, 'MAIN', NOW(), NOW(), NULL),
  (2, 1, 'Entrepôt Secondaire 1', 12, 30000, 'SECONDARY', NOW(), NOW(), NULL),
  (3, 1, 'Entrepôt Secondaire 2', 13, 30000, 'SECONDARY', NOW(), NOW(), NULL),
  (4, 1, 'Entrepôt Régional', 14, 20000, 'REGIONAL', NOW(), NOW(), NULL),
  (5, 1, 'Entrepôt Nord', 15, 25000, 'REGIONAL', NOW(), NOW(), NULL),
  (6, 1, 'Entrepôt Sud', 16, 25000, 'REGIONAL', NOW(), NOW(), NULL),
  (7, 1, 'Entrepôt Est', 17, 25000, 'REGIONAL', NOW(), NOW(), NULL),
  (8, 1, 'Entrepôt Ouest', 18, 25000, 'REGIONAL', NOW(), NOW(), NULL),
  (9, 1, 'Entrepôt Central', 19, 40000, 'MAIN', NOW(), NOW(), NULL),
  (10, 1, 'Entrepôt Logistique', 20, 40000, 'LOGISTIC', NOW(), NOW(), NULL);

-- ==================================================
--                     Camions
-- ==================================================

INSERT INTO trucks (id, company_id, license_plate, capacity, model, created_at, updated_at, deleted_at) VALUES
  (1, 1, 'AB-123-CD', 10000, 'Volvo FH16', NOW(), NOW(), NULL),
  (2, 1, 'EF-456-GH', 8000, 'Scania R500', NOW(), NOW(), NULL),
  (3, 1, 'IJ-789-KL', 12000, 'Mercedes Actros', NOW(), NOW(), NULL),
  (4, 1, 'MN-012-OP', 9000, 'DAF XF', NOW(), NOW(), NULL),
  (5, 1, 'QR-345-ST', 11000, 'MAN TGX', NOW(), NOW(), NULL),
  (6, 1, 'UV-678-WX', 7000, 'Iveco Stralis', NOW(), NOW(), NULL),
  (7, 1, 'YZ-901-AB', 9500, 'Renault Magnum', NOW(), NOW(), NULL),
  (8, 1, 'CD-234-EF', 10500, 'Freightliner Cascadia', NOW(), NOW(), NULL),
  (9, 1, 'GH-567-IJ', 11500, 'Kenworth T680', NOW(), NOW(), NULL),
  (10, 1, 'KL-890-MN', 8500, 'Peterbilt 579', NOW(), NOW(), NULL),
  
  -- Camions 11 à 30
  (11, 1, 'OP-123-QR', 9800, 'Volvo FH12', NOW(), NOW(), NULL),
  (12, 1, 'ST-456-UV', 7600, 'Scania G410', NOW(), NOW(), NULL),
  (13, 1, 'WX-789-YZ', 10200, 'Mercedes Atego', NOW(), NOW(), NULL),
  (14, 1, 'AB-012-CD', 8800, 'DAF CF', NOW(), NOW(), NULL),
  (15, 1, 'EF-345-GH', 9700, 'MAN TGS', NOW(), NOW(), NULL),
  (16, 1, 'IJ-678-KL', 8300, 'Iveco Daily', NOW(), NOW(), NULL),
  (17, 1, 'MN-901-OP', 9200, 'Renault Premium', NOW(), NOW(), NULL),
  (18, 1, 'QR-234-ST', 10100, 'Freightliner M2 106', NOW(), NOW(), NULL),
  (19, 1, 'UV-567-WX', 9900, 'Kenworth T880', NOW(), NOW(), NULL),
  (20, 1, 'YZ-890-AB', 8700, 'Peterbilt 389', NOW(), NOW(), NULL),
  
  (21, 1, 'CD-123-EF', 9400, 'Volvo VNL', NOW(), NOW(), NULL),
  (22, 1, 'GH-456-IJ', 9300, 'Scania S730', NOW(), NOW(), NULL),
  (23, 1, 'KL-789-MN', 8900, 'Mercedes-Benz Actros', NOW(), NOW(), NULL),
  (24, 1, 'OP-012-QR', 9600, 'DAF XF', NOW(), NOW(), NULL),
  (25, 1, 'ST-345-UV', 8600, 'MAN TGX', NOW(), NOW(), NULL),
  (26, 1, 'WX-678-YZ', 9800, 'Iveco Stralis', NOW(), NOW(), NULL),
  (27, 1, 'AB-901-CD', 9100, 'Renault Magnum', NOW(), NOW(), NULL),
  (28, 1, 'EF-234-GH', 10000, 'Freightliner Cascadia', NOW(), NOW(), NULL),
  (29, 1, 'IJ-567-KL', 9200, 'Kenworth T680', NOW(), NOW(), NULL),
  (30, 1, 'MN-890-OP', 8800, 'Peterbilt 579', NOW(), NOW(), NULL);

-- ==================================================
--                    Chauffeurs
-- ==================================================

INSERT INTO drivers (id, company_id, name, license_number, license_expiry_date, phone, driver_status, created_at, updated_at, deleted_at) VALUES
  (1, 1, 'Marc Lefèvre', 'DRV-123456', '2025-12-31', '+33-6-12-34-56-78', 'ACTIVE', NOW(), NOW(), NULL),
  (2, 1, 'Claire Martin', 'DRV-234567', '2026-06-30', '+33-6-23-45-67-89', 'ACTIVE', NOW(), NOW(), NULL),
  (3, 1, 'Julien Moreau', 'DRV-345678', '2024-09-15', '+33-6-34-56-78-90', 'ACTIVE', NOW(), NOW(), NULL),
  (4, 1, 'Elise Bernard', 'DRV-456789', '2027-03-20', '+33-6-45-67-89-01', 'ACTIVE', NOW(), NOW(), NULL),
  (5, 1, 'Lucas Petit', 'DRV-567890', '2025-11-05', '+33-6-56-78-90-12', 'ACTIVE', NOW(), NOW(), NULL),
  (6, 1, 'Marie Dubois', 'DRV-678901', '2026-08-25', '+33-6-67-89-01-23', 'ACTIVE', NOW(), NOW(), NULL),
  (7, 1, 'Thomas Roux', 'DRV-789012', '2025-05-14', '+33-6-78-90-12-34', 'ACTIVE', NOW(), NOW(), NULL),
  (8, 1, 'Sophie Mercier', 'DRV-890123', '2024-10-30', '+33-6-89-01-23-45', 'ACTIVE', NOW(), NOW(), NULL),
  (9, 1, 'Antoine Lefebvre', 'DRV-901234', '2027-01-10', '+33-6-90-12-34-56', 'ACTIVE', NOW(), NOW(), NULL),
  (10, 1, 'Camille Girard', 'DRV-012345', '2026-04-22', '+33-6-01-23-45-67', 'ACTIVE', NOW(), NOW(), NULL),
  
  -- Chauffeurs 11 à 50
  (11, 1, 'Nathan Lambert', 'DRV-112233', '2025-07-18', '+33-6-22-33-44-55', 'ACTIVE', NOW(), NOW(), NULL),
  (12, 1, 'Léa Dupuis', 'DRV-223344', '2026-02-28', '+33-6-33-44-55-66', 'ACTIVE', NOW(), NOW(), NULL),
  (13, 1, 'Maxime Faure', 'DRV-334455', '2024-12-12', '+33-6-44-55-66-77', 'ACTIVE', NOW(), NOW(), NULL),
  (14, 1, 'Clara Bonnet', 'DRV-445566', '2027-05-05', '+33-6-55-66-77-88', 'ACTIVE', NOW(), NOW(), NULL),
  (15, 1, 'Benjamin Rouillard', 'DRV-556677', '2025-09-09', '+33-6-66-77-88-99', 'ACTIVE', NOW(), NOW(), NULL),
  (16, 1, 'Aurélie Fontaine', 'DRV-667788', '2026-11-11', '+33-6-77-88-99-00', 'ACTIVE', NOW(), NOW(), NULL),
  (17, 1, 'Mathieu Rousseau', 'DRV-778899', '2024-08-08', '+33-6-88-99-00-11', 'ACTIVE', NOW(), NOW(), NULL),
  (18, 1, 'Caroline Garcia', 'DRV-889900', '2027-02-02', '+33-6-99-00-11-22', 'ACTIVE', NOW(), NOW(), NULL),
  (19, 1, 'Romain Leclerc', 'DRV-990011', '2025-10-10', '+33-6-00-11-22-33', 'ACTIVE', NOW(), NOW(), NULL),
  (20, 1, 'Hélène Dubois', 'DRV-101112', '2026-03-03', '+33-6-11-22-33-44', 'ACTIVE', NOW(), NOW(), NULL),
  
  (21, 1, 'Paul Gauthier', 'DRV-121314', '2025-06-06', '+33-6-12-34-56-79', 'ACTIVE', NOW(), NOW(), NULL),
  (22, 1, 'Emma Petit', 'DRV-131415', '2026-07-07', '+33-6-23-45-67-80', 'ACTIVE', NOW(), NOW(), NULL),
  (23, 1, 'Léo Bernard', 'DRV-141516', '2024-05-05', '+33-6-34-56-78-91', 'ACTIVE', NOW(), NOW(), NULL),
  (24, 1, 'Chloé Lefèvre', 'DRV-151617', '2027-04-04', '+33-6-45-67-89-02', 'ACTIVE', NOW(), NOW(), NULL),
  (25, 1, 'Gabriel Morel', 'DRV-161718', '2025-08-08', '+33-6-56-78-90-13', 'ACTIVE', NOW(), NOW(), NULL),
  (26, 1, 'Inès Marchand', 'DRV-171819', '2026-09-09', '+33-6-67-89-01-24', 'ACTIVE', NOW(), NOW(), NULL),
  (27, 1, 'Lucas Blanc', 'DRV-181920', '2024-10-10', '+33-6-78-90-12-35', 'ACTIVE', NOW(), NOW(), NULL),
  (28, 1, 'Émilie Lefebvre', 'DRV-192021', '2027-11-11', '+33-6-89-01-23-46', 'ACTIVE', NOW(), NOW(), NULL),
  (29, 1, 'Victor Rousseau', 'DRV-202122', '2025-12-12', '+33-6-90-12-34-57', 'ACTIVE', NOW(), NOW(), NULL),
  (30, 1, 'Lily Laurent', 'DRV-212223', '2026-01-01', '+33-6-01-23-45-68', 'ACTIVE', NOW(), NOW(), NULL),
  
  (31, 1, 'Sébastien Dupont', 'DRV-222324', '2025-07-07', '+33-6-13-34-56-79', 'ACTIVE', NOW(), NOW(), NULL),
  (32, 1, 'Élodie Martin', 'DRV-232425', '2026-08-08', '+33-6-14-45-67-80', 'ACTIVE', NOW(), NOW(), NULL),
  (33, 1, 'Adrien Caron', 'DRV-242526', '2024-09-09', '+33-6-15-56-78-91', 'ACTIVE', NOW(), NOW(), NULL),
  (34, 1, 'Laura Picard', 'DRV-252627', '2027-10-10', '+33-6-16-67-89-02', 'ACTIVE', NOW(), NOW(), NULL),
  (35, 1, 'Mathieu Leclerc', 'DRV-262728', '2025-11-11', '+33-6-17-78-90-13', 'ACTIVE', NOW(), NOW(), NULL),
  (36, 1, 'Élise Fournier', 'DRV-272829', '2026-12-12', '+33-6-18-89-01-24', 'ACTIVE', NOW(), NOW(), NULL),
  (37, 1, 'Adrien Marchal', 'DRV-282930', '2024-10-10', '+33-6-19-90-12-35', 'ACTIVE', NOW(), NOW(), NULL),
  (38, 1, 'Claire Picard', 'DRV-293031', '2027-01-01', '+33-6-20-01-23-46', 'ACTIVE', NOW(), NOW(), NULL),
  (39, 1, 'Gabriel Girard', 'DRV-303132', '2025-02-02', '+33-6-21-12-34-57', 'ACTIVE', NOW(), NOW(), NULL),
  (40, 1, 'Mathieu Leclerc', 'DRV-313233', '2026-03-03', '+33-6-22-23-45-68', 'ACTIVE', NOW(), NOW(), NULL),
  
  -- Continuez jusqu'à 50 chauffeurs en suivant le même schéma
  (41, 1, 'Emma Laurent', 'DRV-323334', '2025-04-04', '+33-6-23-34-56-79', 'ACTIVE', NOW(), NOW(), NULL),
  (42, 1, 'Lucas Garcia', 'DRV-333435', '2026-05-05', '+33-6-24-45-67-80', 'ACTIVE', NOW(), NOW(), NULL),
  (43, 1, 'Chloé Bernard', 'DRV-343536', '2024-06-06', '+33-6-25-56-78-91', 'ACTIVE', NOW(), NOW(), NULL),
  (44, 1, 'Victor Petit', 'DRV-353637', '2027-07-07', '+33-6-26-67-89-02', 'ACTIVE', NOW(), NOW(), NULL),
  (45, 1, 'Sophie Moreau', 'DRV-363738', '2025-08-08', '+33-6-27-78-90-13', 'ACTIVE', NOW(), NOW(), NULL),
  (46, 1, 'Nathan Blanc', 'DRV-373839', '2026-09-09', '+33-6-28-89-01-24', 'ACTIVE', NOW(), NOW(), NULL),
  (47, 1, 'Émilie Lefèvre', 'DRV-383940', '2024-10-10', '+33-6-29-90-12-35', 'ACTIVE', NOW(), NOW(), NULL),
  (48, 1, 'Maxime Roux', 'DRV-394041', '2027-11-11', '+33-6-30-01-23-46', 'ACTIVE', NOW(), NOW(), NULL),
  (49, 1, 'Clara Dubois', 'DRV-404142', '2025-12-12', '+33-6-31-12-34-57', 'ACTIVE', NOW(), NOW(), NULL),
  (50, 1, 'Julien Garcia', 'DRV-414243', '2026-01-01', '+33-6-32-23-45-68', 'ACTIVE', NOW(), NOW(), NULL);

-- ==================================================
--                     Produits
-- ==================================================

INSERT INTO products (id, company_id, name, weight, unit_id, description, created_at, updated_at, deleted_at) VALUES
  (1, 1, 'UltraWidget 3000', 15, 1, 'Le UltraWidget 3000 est un produit innovant pour vos besoins de logistique.', NOW(), NOW(), NULL),
  (2, 1, 'EcoGadget Pro', 8, 1, 'EcoGadget Pro, respectueux de l environnement et performant.', NOW(), NOW(), NULL),
  (3, 1, 'MaxiBox 500', 20, 1, 'MaxiBox 500, la solution parfaite pour le stockage.', NOW(), NOW(), NULL),
  (4, 1, 'SpeedyLoader X', 12, 1, 'SpeedyLoader X, pour un chargement rapide et efficace.', NOW(), NOW(), NULL),
  (5, 1, 'SecureLock 200', 5, 1, 'SecureLock 200, assurez la sécurité de vos expéditions.', NOW(), NOW(), NULL),
  (6, 1, 'FlexiPack 100', 7, 1, 'FlexiPack 100, adaptable à tous vos besoins d emballage.', NOW(), NOW(), NULL),
  (7, 1, 'RapidTransit 50', 10, 1, 'RapidTransit 50, optimisez vos trajets de livraison.', NOW(), NOW(), NULL),
  (8, 1, 'SmartRoute 75', 9, 1, 'SmartRoute 75, planifiez vos itinéraires intelligemment.', NOW(), NOW(), NULL),
  (9, 1, 'HeavyDuty 400', 25, 1, 'HeavyDuty 400, conçu pour les charges lourdes.', NOW(), NOW(), NULL),
  (10, 1, 'LightCarry 150', 3, 1, 'LightCarry 150, idéal pour les petites livraisons.', NOW(), NOW(), NULL),
  
  (11, 1, 'PowerMover 250', 18, 1, 'PowerMover 250, efficacité et robustesse.', NOW(), NOW(), NULL),
  (12, 1, 'EcoTransporter 300', 22, 1, 'EcoTransporter 300, transport écologique et fiable.', NOW(), NOW(), NULL),
  (13, 1, 'CargoMaster 500', 30, 1, 'CargoMaster 500, pour de grandes expéditions.', NOW(), NOW(), NULL),
  (14, 1, 'QuickLoad 200', 14, 1, 'QuickLoad 200, chargez rapidement vos marchandises.', NOW(), NOW(), NULL),
  (15, 1, 'SecureTransport 100', 6, 1, 'SecureTransport 100, transport sécurisé garanti.', NOW(), NOW(), NULL),
  (16, 1, 'FlexiContainer 80', 11, 1, 'FlexiContainer 80, conteneur flexible pour tous usages.', NOW(), NOW(), NULL),
  (17, 1, 'RapidDeliver 60', 7, 1, 'RapidDeliver 60, livraison rapide et ponctuelle.', NOW(), NOW(), NULL),
  (18, 1, 'SmartFleet 90', 10, 1, 'SmartFleet 90, gestion intelligente de votre flotte.', NOW(), NOW(), NULL),
  (19, 1, 'HeavyLoad 450', 28, 1, 'HeavyLoad 450, pour les charges lourdes.', NOW(), NOW(), NULL),
  (20, 1, 'LightMove 120', 4, 1, 'LightMove 120, parfait pour les livraisons légères.', NOW(), NOW(), NULL),
  
  (21, 1, 'PowerLift 320', 19, 1, 'PowerLift 320, soulevez et transportez avec facilité.', NOW(), NOW(), NULL),
  (22, 1, 'EcoCarrier 270', 21, 1, 'EcoCarrier 270, transport écologique et efficace.', NOW(), NOW(), NULL),
  (23, 1, 'CargoExpress 550', 35, 1, 'CargoExpress 550, expéditions rapides et sécurisées.', NOW(), NOW(), NULL),
  (24, 1, 'QuickTransit 220', 16, 1, 'QuickTransit 220, transit rapide de vos marchandises.', NOW(), NOW(), NULL),
  (25, 1, 'SecureBox 130', 8, 1, 'SecureBox 130, pour un emballage sécurisé.', NOW(), NOW(), NULL),
  (26, 1, 'FlexiLoad 90', 12, 1, 'FlexiLoad 90, chargez et déchargez avec flexibilité.', NOW(), NOW(), NULL),
  (27, 1, 'RapidFleet 70', 9, 1, 'RapidFleet 70, optimisation de votre flotte en temps réel.', NOW(), NOW(), NULL),
  (28, 1, 'SmartContainer 110', 10, 1, 'SmartContainer 110, conteneurs intelligents pour vos besoins.', NOW(), NOW(), NULL),
  (29, 1, 'HeavyMover 480', 27, 1, 'HeavyMover 480, pour les charges très lourdes.', NOW(), NOW(), NULL),
  (30, 1, 'LightShip 140', 5, 1, 'LightShip 140, expéditions légères et rapides.', NOW(), NOW(), NULL),
  
  (31, 1, 'UltraFlex 500', 20, 1, 'UltraFlex 500, flexibilité maximale pour toutes vos livraisons.', NOW(), NOW(), NULL),
  (32, 1, 'EcoMover 600', 22, 1, 'EcoMover 600, transport écologique et puissant.', NOW(), NOW(), NULL),
  (33, 1, 'CargoPlus 700', 28, 1, 'CargoPlus 700, solution avancée pour de grands volumes.', NOW(), NOW(), NULL),
  (34, 1, 'SpeedBox 800', 15, 1, 'SpeedBox 800, rapidité et efficacité combinées.', NOW(), NOW(), NULL),
  (35, 1, 'SecureTransit 900', 10, 1, 'SecureTransit 900, sécurité renforcée pour vos expéditions.', NOW(), NOW(), NULL),
  (36, 1, 'FlexiShip 1000', 18, 1, 'FlexiShip 1000, flexibilité et robustesse assurées.', NOW(), NOW(), NULL),
  (37, 1, 'RapidLoad 1100', 12, 1, 'RapidLoad 1100, chargez et déchargez en un clin d œil.', NOW(), NOW(), NULL),
  (38, 1, 'SmartFleet 1200', 20, 1, 'SmartFleet 1200, gestion intelligente de votre flotte.', NOW(), NOW(), NULL),
  (39, 1, 'HeavyLoad 1300', 30, 1, 'HeavyLoad 1300, conçu pour les charges très lourdes.', NOW(), NOW(), NULL),
  (40, 1, 'LightMove 1400', 5, 1, 'LightMove 1400, parfait pour les livraisons légères.', NOW(), NOW(), NULL),
  
  (41, 1, 'PowerLift 1500', 19, 1, 'PowerLift 1500, soulevez et transportez avec facilité.', NOW(), NOW(), NULL),
  (42, 1, 'EcoCarrier 1600', 21, 1, 'EcoCarrier 1600, transport écologique et efficace.', NOW(), NOW(), NULL),
  (43, 1, 'CargoExpress 1700', 35, 1, 'CargoExpress 1700, expéditions rapides et sécurisées.', NOW(), NOW(), NULL),
  (44, 1, 'QuickTransit 1800', 16, 1, 'QuickTransit 1800, transit rapide de vos marchandises.', NOW(), NOW(), NULL),
  (45, 1, 'SecureBox 1900', 8, 1, 'SecureBox 1900, pour un emballage sécurisé.', NOW(), NOW(), NULL),
  (46, 1, 'FlexiLoad 2000', 12, 1, 'FlexiLoad 2000, chargez et déchargez avec flexibilité.', NOW(), NOW(), NULL),
  (47, 1, 'RapidFleet 2100', 9, 1, 'RapidFleet 2100, optimisation de votre flotte en temps réel.', NOW(), NOW(), NULL),
  (48, 1, 'SmartContainer 2200', 10, 1, 'SmartContainer 2200, conteneurs intelligents pour vos besoins.', NOW(), NOW(), NULL),
  (49, 1, 'HeavyMover 2300', 27, 1, 'HeavyMover 2300, pour les charges très lourdes.', NOW(), NOW(), NULL),
  (50, 1, 'LightShip 2400', 5, 1, 'LightShip 2400, expéditions légères et rapides.', NOW(), NOW(), NULL);

-- ==================================================
--                     Commandes
-- ==================================================

-- Exemple de commandes avec des clients et des statuts variés
INSERT INTO orders (id, company_id, customer_id, warehouse_id, total_weight, status_id, created_at, updated_at, deleted_at) VALUES
  (1, 1, 1, 1, 150, 1, '2024-01-10 08:00:00+01', '2024-01-10 08:00:00+01', NULL),
  (2, 1, 2, 1, 200, 2, '2024-01-11 09:30:00+01', '2024-01-11 09:30:00+01', NULL),
  (3, 1, 3, 2, 75, 3, '2024-01-12 10:15:00+01', '2024-01-12 10:15:00+01', NULL),
  (4, 1, 4, 3, 120, 4, '2024-01-13 11:45:00+01', '2024-01-13 11:45:00+01', NULL),
  (5, 1, 5, 4, 60, 5, '2024-01-14 13:20:00+01', '2024-01-14 13:20:00+01', NULL),
  (6, 1, 6, 5, 180, 6, '2024-01-15 14:50:00+01', '2024-01-15 14:50:00+01', NULL),
  (7, 1, 7, 6, 90, 7, '2024-01-16 16:10:00+01', '2024-01-16 16:10:00+01', NULL),
  (8, 1, 8, 7, 210, 8, '2024-01-17 17:30:00+01', '2024-01-17 17:30:00+01', NULL),
  (9, 1, 9, 8, 130, 9, '2024-01-18 18:45:00+01', '2024-01-18 18:45:00+01', NULL),
  (10, 1, 10, 9, 50, 10, '2024-01-19 20:00:00+01', '2024-01-19 20:00:00+01', NULL),
  
  -- Commandes 11 à 200
  (11, 1, 11, 10, 160, 1, '2024-01-20 08:30:00+01', '2024-01-20 08:30:00+01', NULL),
  (12, 1, 12, 1, 190, 2, '2024-01-21 09:45:00+01', '2024-01-21 09:45:00+01', NULL),
  (13, 1, 13, 2, 85, 3, '2024-01-22 11:00:00+01', '2024-01-22 11:00:00+01', NULL),
  (14, 1, 14, 3, 125, 4, '2024-01-23 12:20:00+01', '2024-01-23 12:20:00+01', NULL),
  (15, 1, 15, 4, 65, 5, '2024-01-24 13:40:00+01', '2024-01-24 13:40:00+01', NULL),
  (16, 1, 16, 5, 175, 6, '2024-01-25 15:00:00+01', '2024-01-25 15:00:00+01', NULL),
  (17, 1, 17, 6, 95, 7, '2024-01-26 16:15:00+01', '2024-01-26 16:15:00+01', NULL),
  (18, 1, 18, 7, 220, 8, '2024-01-27 17:30:00+01', '2024-01-27 17:30:00+01', NULL),
  (19, 1, 19, 8, 140, 9, '2024-01-28 18:45:00+01', '2024-01-28 18:45:00+01', NULL),
  (20, 1, 20, 9, 55, 10, '2024-01-29 20:00:00+01', '2024-01-29 20:00:00+01', NULL),
  
  (21, 1, 21, 10, 165, 1, '2024-01-30 08:30:00+01', '2024-01-30 08:30:00+01', NULL),
  (22, 1, 22, 1, 185, 2, '2024-01-31 09:45:00+01', '2024-01-31 09:45:00+01', NULL),
  -- ... (Continuez jusqu'à 200 commandes en suivant le même schéma)
  (200, 1, 100, 10, 165, 1, '2024-06-10 09:00:00+01', '2024-06-10 09:00:00+01', NULL);

-- ==================================================
--                 Détails de Commande
-- ==================================================

-- Exemple de détails de commande pour les premières commandes
INSERT INTO order_items (id, order_id, product_id, quantity, unit_weight, created_at, updated_at, deleted_at) VALUES
  -- Commande 1
  (1, 1, 1, 5, 15, NOW(), NOW(), NULL),
  (2, 1, 3, 2, 20, NOW(), NOW(), NULL),
  
  -- Commande 2
  (3, 2, 2, 10, 8, NOW(), NOW(), NULL),
  (4, 2, 4, 3, 12, NOW(), NOW(), NULL),
  
  -- Commande 3
  (5, 3, 5, 4, 5, NOW(), NOW(), NULL),
  (6, 3, 6, 7, 7, NOW(), NOW(), NULL),
  
  -- Commande 4
  (7, 4, 7, 6, 10, NOW(), NOW(), NULL),
  (8, 4, 8, 2, 9, NOW(), NOW(), NULL),
  
  -- Commande 5
  (9, 5, 9, 3, 25, NOW(), NOW(), NULL),
  (10, 5, 10, 10, 3, NOW(), NOW(), NULL),
  
  -- Commande 6
  (11, 6, 1, 8, 15, NOW(), NOW(), NULL),
  (12, 6, 3, 5, 20, NOW(), NOW(), NULL),
  
  -- Commande 7
  (13, 7, 2, 12, 8, NOW(), NOW(), NULL),
  (14, 7, 4, 4, 12, NOW(), NOW(), NULL),
  
  -- Commande 8
  (15, 8, 5, 6, 5, NOW(), NOW(), NULL),
  (16, 8, 6, 9, 7, NOW(), NOW(), NULL),
  
  -- Commande 9
  (17, 9, 7, 7, 10, NOW(), NOW(), NULL),
  (18, 9, 8, 3, 9, NOW(), NOW(), NULL),
  
  -- Commande 10
  (19, 10, 9, 4, 25, NOW(), NOW(), NULL),
  (20, 10, 10, 15, 3, NOW(), NOW(), NULL),
  
  -- Détails des commandes 11 à 200
  (21, 11, 1, 6, 15, NOW(), NOW(), NULL),
  (22, 11, 3, 3, 20, NOW(), NOW(), NULL),
  (23, 12, 2, 11, 8, NOW(), NOW(), NULL),
  (24, 12, 4, 5, 12, NOW(), NOW(), NULL),
  (25, 13, 5, 7, 5, NOW(), NOW(), NULL),
  (26, 13, 6, 10, 7, NOW(), NOW(), NULL),
  (27, 14, 7, 8, 10, NOW(), NOW(), NULL),
  (28, 14, 8, 4, 9, NOW(), NOW(), NULL),
  (29, 15, 9, 5, 25, NOW(), NOW(), NULL),
  (30, 15, 10, 20, 3, NOW(), NOW(), NULL),
  
  -- ... (Continuez jusqu'à 500 détails de commande en suivant le même schéma)
  (500, 200, 10, 5, 3, NOW(), NOW(), NULL);

-- ==================================================
--                      Routes
-- ==================================================

INSERT INTO routes (id, company_id, name, start_warehouse_id, end_warehouse_id, created_at, updated_at, deleted_at) VALUES
  (1, 1, 'Route Paris-Lyon', 1, 2, NOW(), NOW(), NULL),
  (2, 1, 'Route Lyon-Marseille', 2, 3, NOW(), NOW(), NULL),
  (3, 1, 'Route Marseille-Toulouse', 3, 4, NOW(), NOW(), NULL),
  (4, 1, 'Route Toulouse-Nice', 4, 5, NOW(), NOW(), NULL),
  (5, 1, 'Route Nice-Bordeaux', 5, 6, NOW(), NOW(), NULL),
  (6, 1, 'Route Bordeaux-Lille', 6, 7, NOW(), NOW(), NULL),
  (7, 1, 'Route Lille-Strasbourg', 7, 8, NOW(), NOW(), NULL),
  (8, 1, 'Route Strasbourg-Nantes', 8, 9, NOW(), NOW(), NULL),
  (9, 1, 'Route Nantes-Montpellier', 9, 10, NOW(), NOW(), NULL),
  (10, 1, 'Route Montpellier-Paris', 10, 1, NOW(), NOW(), NULL);

-- ==================================================
--                  Arrêts de Route
-- ==================================================

INSERT INTO route_stops (id, route_id, warehouse_id, stop_order, stop_type, arrival_eta, departure_eta, actual_arrival, actual_departure, created_at, updated_at, deleted_at) VALUES
  -- Route 1: Paris-Lyon
  (1, 1, 1, 1, 'WAREHOUSE', '2024-01-10 09:00:00+01', '2024-01-10 09:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  (2, 1, 2, 2, 'WAREHOUSE', '2024-01-10 12:00:00+01', '2024-01-10 12:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  
  -- Route 2: Lyon-Marseille
  (3, 2, 2, 1, 'WAREHOUSE', '2024-01-11 10:00:00+01', '2024-01-11 10:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  (4, 2, 3, 2, 'WAREHOUSE', '2024-01-11 13:00:00+01', '2024-01-11 13:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  
  -- Route 3: Marseille-Toulouse
  (5, 3, 3, 1, 'WAREHOUSE', '2024-01-12 11:00:00+01', '2024-01-12 11:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  (6, 3, 4, 2, 'WAREHOUSE', '2024-01-12 14:00:00+01', '2024-01-12 14:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  
  -- Route 4: Toulouse-Nice
  (7, 4, 4, 1, 'WAREHOUSE', '2024-01-13 12:00:00+01', '2024-01-13 12:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  (8, 4, 5, 2, 'WAREHOUSE', '2024-01-13 15:00:00+01', '2024-01-13 15:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  
  -- Route 5: Nice-Bordeaux
  (9, 5, 5, 1, 'WAREHOUSE', '2024-01-14 13:00:00+01', '2024-01-14 13:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  (10, 5, 6, 2, 'WAREHOUSE', '2024-01-14 16:00:00+01', '2024-01-14 16:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  
  -- Route 6: Bordeaux-Lille
  (11, 6, 6, 1, 'WAREHOUSE', '2024-01-15 14:00:00+01', '2024-01-15 14:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  (12, 6, 7, 2, 'WAREHOUSE', '2024-01-15 17:00:00+01', '2024-01-15 17:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  
  -- Route 7: Lille-Strasbourg
  (13, 7, 7, 1, 'WAREHOUSE', '2024-01-16 15:00:00+01', '2024-01-16 15:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  (14, 7, 8, 2, 'WAREHOUSE', '2024-01-16 18:00:00+01', '2024-01-16 18:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  
  -- Route 8: Strasbourg-Nantes
  (15, 8, 8, 1, 'WAREHOUSE', '2024-01-17 16:00:00+01', '2024-01-17 16:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  (16, 8, 9, 2, 'WAREHOUSE', '2024-01-17 19:00:00+01', '2024-01-17 19:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  
  -- Route 9: Nantes-Montpellier
  (17, 9, 9, 1, 'WAREHOUSE', '2024-01-18 17:00:00+01', '2024-01-18 17:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  (18, 9, 10, 2, 'WAREHOUSE', '2024-01-18 20:00:00+01', '2024-01-18 20:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  
  -- Route 10: Montpellier-Paris
  (19, 10, 10, 1, 'WAREHOUSE', '2024-01-19 18:00:00+01', '2024-01-19 18:30:00+01', NULL, NULL, NOW(), NOW(), NULL),
  (20, 10, 1, 2, 'WAREHOUSE', '2024-01-19 21:00:00+01', '2024-01-19 21:30:00+01', NULL, NULL, NOW(), NOW(), NULL);

-- ==================================================
--                    Expéditions
-- ==================================================

INSERT INTO shipments (id, order_id, truck_id, driver_id, route_id, status_id, created_at, updated_at, deleted_at) VALUES
  (1, 1, 1, 1, 1, 1, '2024-01-10 08:30:00+01', '2024-01-10 08:30:00+01', NULL),
  (2, 2, 2, 2, 2, 2, '2024-01-11 09:45:00+01', '2024-01-11 09:45:00+01', NULL),
  (3, 3, 3, 3, 3, 3, '2024-01-12 10:30:00+01', '2024-01-12 10:30:00+01', NULL),
  (4, 4, 4, 4, 4, 4, '2024-01-13 11:50:00+01', '2024-01-13 11:50:00+01', NULL),
  (5, 5, 5, 5, 5, 5, '2024-01-14 13:15:00+01', '2024-01-14 13:15:00+01', NULL),
  (6, 6, 6, 6, 6, 6, '2024-01-15 14:40:00+01', '2024-01-15 14:40:00+01', NULL),
  (7, 7, 7, 7, 7, 7, '2024-01-16 16:00:00+01', '2024-01-16 16:00:00+01', NULL),
  (8, 8, 8, 8, 8, 8, '2024-01-17 17:20:00+01', '2024-01-17 17:20:00+01', NULL),
  (9, 9, 9, 9, 9, 9, '2024-01-18 18:35:00+01', '2024-01-18 18:35:00+01', NULL),
  (10, 10, 10, 10, 10, 10, '2024-01-19 19:50:00+01', '2024-01-19 19:50:00+01', NULL),
  
  -- Expéditions 11 à 200
  (11, 11, 11, 11, 1, 1, '2024-01-20 08:30:00+01', '2024-01-20 08:30:00+01', NULL),
  (12, 12, 12, 12, 2, 2, '2024-01-21 09:45:00+01', '2024-01-21 09:45:00+01', NULL),
  (13, 13, 13, 13, 3, 3, '2024-01-22 10:30:00+01', '2024-01-22 10:30:00+01', NULL),
  (14, 14, 14, 14, 4, 4, '2024-01-23 11:50:00+01', '2024-01-23 11:50:00+01', NULL),
  (15, 15, 15, 15, 5, 5, '2024-01-24 13:15:00+01', '2024-01-24 13:15:00+01', NULL),
  (16, 16, 16, 16, 6, 6, '2024-01-25 14:40:00+01', '2024-01-25 14:40:00+01', NULL),
  (17, 17, 17, 17, 7, 7, '2024-01-26 16:00:00+01', '2024-01-26 16:00:00+01', NULL),
  (18, 18, 18, 18, 8, 8, '2024-01-27 17:20:00+01', '2024-01-27 17:20:00+01', NULL),
  (19, 19, 19, 19, 9, 9, '2024-01-28 18:35:00+01', '2024-01-28 18:35:00+01', NULL),
  (20, 20, 20, 20, 10, 10, '2024-01-29 19:50:00+01', '2024-01-29 19:50:00+01', NULL),
  
  (21, 21, 21, 21, 1, 1, '2024-01-30 08:30:00+01', '2024-01-30 08:30:00+01', NULL),
  (22, 22, 22, 22, 2, 2, '2024-01-31 09:45:00+01', '2024-01-31 09:45:00+01', NULL);

-- ==================================================
--             Événements d’Expédition
-- ==================================================

INSERT INTO shipment_events (id, shipment_id, event_status_id, event_time, comment, created_at, updated_at, deleted_at) VALUES
  -- Expédition 1
  (1, 1, 1, '2024-01-10 08:30:00+01', 'Expédition créée', NOW(), NOW(), NULL),
  (2, 1, 2, '2024-01-10 09:00:00+01', 'Ramassage effectué', NOW(), NOW(), NULL),
  (3, 1, 3, '2024-01-10 12:00:00+01', 'En transit vers le client', NOW(), NOW(), NULL),
  (4, 1, 4, '2024-01-10 14:30:00+01', 'Livraison effectuée', NOW(), NOW(), NULL),
  
  -- Expédition 2
  (5, 2, 1, '2024-01-11 09:45:00+01', 'Expédition créée', NOW(), NOW(), NULL),
  (6, 2, 2, '2024-01-11 10:15:00+01', 'Ramassage effectué', NOW(), NOW(), NULL),
  (7, 2, 3, '2024-01-11 12:30:00+01', 'En transit vers le client', NOW(), NOW(), NULL),
  (8, 2, 4, '2024-01-11 15:00:00+01', 'Livraison effectuée', NOW(), NOW(), NULL),
  
  -- Expédition 3
  (9, 3, 1, '2024-01-12 10:30:00+01', 'Expédition créée', NOW(), NOW(), NULL),
  (10, 3, 2, '2024-01-12 11:00:00+01', 'Ramassage effectué', NOW(), NOW(), NULL),
  (11, 3, 3, '2024-01-12 13:15:00+01', 'En transit vers le client', NOW(), NOW(), NULL),
  (12, 3, 4, '2024-01-12 16:00:00+01', 'Livraison effectuée', NOW(), NOW(), NULL),
  
  -- Expédition 4
  (13, 4, 1, '2024-01-13 11:50:00+01', 'Expédition créée', NOW(), NOW(), NULL),
  (14, 4, 2, '2024-01-13 12:20:00+01', 'Ramassage effectué', NOW(), NOW(), NULL),
  (15, 4, 3, '2024-01-13 14:30:00+01', 'En transit vers le client', NOW(), NOW(), NULL),
  (16, 4, 4, '2024-01-13 17:00:00+01', 'Livraison effectuée', NOW(), NOW(), NULL),
  
  -- Expédition 5
  (17, 5, 1, '2024-01-14 13:15:00+01', 'Expédition créée', NOW(), NOW(), NULL),
  (18, 5, 2, '2024-01-14 13:45:00+01', 'Ramassage effectué', NOW(), NOW(), NULL),
  (19, 5, 3, '2024-01-14 15:00:00+01', 'En transit vers le client', NOW(), NOW(), NULL),
  (20, 5, 4, '2024-01-14 17:30:00+01', 'Livraison effectuée', NOW(), NOW(), NULL),
  
  -- Événements des expéditions 6 à 200
  (21, 6, 1, '2024-01-15 14:40:00+01', 'Expédition créée', NOW(), NOW(), NULL),
  (22, 6, 2, '2024-01-15 15:10:00+01', 'Ramassage effectué', NOW(), NOW(), NULL),
  (23, 6, 3, '2024-01-15 17:00:00+01', 'En transit vers le client', NOW(), NOW(), NULL),
  (24, 6, 4, '2024-01-15 19:30:00+01', 'Livraison effectuée', NOW(), NOW(), NULL);

-- ==================================================
--                   Utilisateurs Internes
-- ==================================================

INSERT INTO users (id, company_id, email, password_hash, name, role, created_at, updated_at, deleted_at) VALUES
  (1, 1, 'admin@logipro.com', 'hashedpassword1', 'Isabelle Durand', 'ADMIN', NOW(), NOW(), NULL),
  (2, 1, 'manager@logipro.com', 'hashedpassword2', 'Paul Lefevre', 'MANAGER', NOW(), NOW(), NULL),
  (3, 1, 'user1@logipro.com', 'hashedpassword3', 'Claire Moreau', 'USER', NOW(), NOW(), NULL),
  (4, 1, 'user2@logipro.com', 'hashedpassword4', 'Julien Bernard', 'USER', NOW(), NOW(), NULL),
  (5, 1, 'user3@logipro.com', 'hashedpassword5', 'Sophie Dubois', 'USER', NOW(), NOW(), NULL),
  (6, 1, 'user4@logipro.com', 'hashedpassword6', 'Lucas Petit', 'USER', NOW(), NOW(), NULL),
  (7, 1, 'user5@logipro.com', 'hashedpassword7', 'Marie Rousseau', 'USER', NOW(), NOW(), NULL),
  (8, 1, 'user6@logipro.com', 'hashedpassword8', 'Thomas Garcia', 'USER', NOW(), NOW(), NULL),
  (9, 1, 'user7@logipro.com', 'hashedpassword9', 'Elise Lefebvre', 'USER', NOW(), NOW(), NULL),
  (10, 1, 'user8@logipro.com', 'hashedpassword10', 'Benjamin Laurent', 'USER', NOW(), NOW(), NULL),
  
  -- Utilisateurs 11 à 30
  (11, 1, 'user9@logipro.com', 'hashedpassword11', 'Aurélie Simon', 'USER', NOW(), NOW(), NULL),
  (12, 1, 'user10@logipro.com', 'hashedpassword12', 'Mathieu Masson', 'USER', NOW(), NOW(), NULL),
  (13, 1, 'user11@logipro.com', 'hashedpassword13', 'Caroline Picard', 'USER', NOW(), NOW(), NULL),
  (14, 1, 'user12@logipro.com', 'hashedpassword14', 'Romain Fabre', 'USER', NOW(), NOW(), NULL),
  (15, 1, 'user13@logipro.com', 'hashedpassword15', 'Hélène Girard', 'USER', NOW(), NOW(), NULL),
  (16, 1, 'user14@logipro.com', 'hashedpassword16', 'Nathan Lefèvre', 'USER', NOW(), NOW(), NULL),
  (17, 1, 'user15@logipro.com', 'hashedpassword17', 'Léa Garcia', 'USER', NOW(), NOW(), NULL),
  (18, 1, 'user16@logipro.com', 'hashedpassword18', 'Maxime Roux', 'USER', NOW(), NOW(), NULL),
  (19, 1, 'user17@logipro.com', 'hashedpassword19', 'Clara Mercier', 'USER', NOW(), NOW(), NULL),
  (20, 1, 'user18@logipro.com', 'hashedpassword20', 'Benjamin Rousseau', 'USER', NOW(), NOW(), NULL),
  
  (21, 1, 'user19@logipro.com', 'hashedpassword21', 'Laura Petit', 'USER', NOW(), NOW(), NULL),
  (22, 1, 'user20@logipro.com', 'hashedpassword22', 'Gilles Lefèvre', 'USER', NOW(), NOW(), NULL),
  (23, 1, 'user21@logipro.com', 'hashedpassword23', 'Elise Durand', 'USER', NOW(), NOW(), NULL),
  (24, 1, 'user22@logipro.com', 'hashedpassword24', 'Lucas Moreau', 'USER', NOW(), NOW(), NULL),
  (25, 1, 'user23@logipro.com', 'hashedpassword25', 'Clara Dubois', 'USER', NOW(), NOW(), NULL),
  (26, 1, 'user24@logipro.com', 'hashedpassword26', 'Romain Masson', 'USER', NOW(), NOW(), NULL),
  (27, 1, 'user25@logipro.com', 'hashedpassword27', 'Mélanie Roux', 'USER', NOW(), NOW(), NULL),
  (28, 1, 'user26@logipro.com', 'hashedpassword28', 'Lucas Lefebvre', 'USER', NOW(), NOW(), NULL),
  (29, 1, 'user27@logipro.com', 'hashedpassword29', 'Émilie Garcia', 'USER', NOW(), NOW(), NULL),
  (30, 1, 'user30@logipro.com', 'hashedpassword30', 'Morgane Simon', 'USER', NOW(), NOW(), NULL);

-- ==================================================
--                    Factures
-- ==================================================

INSERT INTO invoices (id, order_id, invoice_number, amount, currency, issued_at, paid_at, due_date, status, created_at, updated_at, deleted_at) VALUES
  (1, 1, 'INV-0001', 1500.00, 'EUR', '2024-01-11 10:00:00+01', NULL, '2024-02-10 23:59:59+01', 'PENDING', NOW(), NOW(), NULL),
  (2, 2, 'INV-0002', 2000.00, 'EUR', '2024-01-12 11:00:00+01', '2024-01-20 15:00:00+01', '2024-02-11 23:59:59+01', 'PAID', NOW(), NOW(), NULL),
  (3, 3, 'INV-0003', 750.00, 'EUR', '2024-01-13 12:00:00+01', NULL, '2024-02-12 23:59:59+01', 'PENDING', NOW(), NOW(), NULL),
  (4, 4, 'INV-0004', 1200.00, 'EUR', '2024-01-14 13:00:00+01', '2024-01-25 16:00:00+01', '2024-02-13 23:59:59+01', 'PAID', NOW(), NOW(), NULL),
  (5, 5, 'INV-0005', 600.00, 'EUR', '2024-01-15 14:00:00+01', NULL, '2024-02-14 23:59:59+01', 'PENDING', NOW(), NOW(), NULL),
  (6, 6, 'INV-0006', 1800.00, 'EUR', '2024-01-16 15:00:00+01', '2024-01-26 17:00:00+01', '2024-02-15 23:59:59+01', 'PAID', NOW(), NOW(), NULL),
  (7, 7, 'INV-0007', 900.00, 'EUR', '2024-01-17 16:00:00+01', NULL, '2024-02-16 23:59:59+01', 'PENDING', NOW(), NOW(), NULL),
  (8, 8, 'INV-0008', 2100.00, 'EUR', '2024-01-18 17:00:00+01', '2024-01-28 18:00:00+01', '2024-02-17 23:59:59+01', 'PAID', NOW(), NOW(), NULL),
  (9, 9, 'INV-0009', 1300.00, 'EUR', '2024-01-19 18:00:00+01', NULL, '2024-02-18 23:59:59+01', 'PENDING', NOW(), NOW(), NULL),
  (10, 10, 'INV-0010', 550.00, 'EUR', '2024-01-20 19:00:00+01', '2024-01-30 20:00:00+01', '2024-02-19 23:59:59+01', 'PAID', NOW(), NOW(), NULL),
  
  -- Factures 11 à 200
  (11, 11, 'INV-0011', 1600.00, 'EUR', '2024-01-21 10:00:00+01', NULL, '2024-02-20 23:59:59+01', 'PENDING', NOW(), NOW(), NULL),
  (12, 12, 'INV-0012', 1900.00, 'EUR', '2024-01-22 11:00:00+01', '2024-02-01 12:00:00+01', '2024-02-21 23:59:59+01', 'PAID', NOW(), NOW(), NULL),
  (13, 13, 'INV-0013', 800.00, 'EUR', '2024-01-23 12:00:00+01', NULL, '2024-02-22 23:59:59+01', 'PENDING', NOW(), NOW(), NULL);
  

-- ==================================================
--                   Paiements
-- ==================================================

INSERT INTO payments (id, invoice_id, payment_method, amount, paid_at, note, created_at, updated_at, deleted_at) VALUES
  (1, 2, 'BANK_TRANSFER', 2000.00, '2024-01-20 15:00:00+01', 'Paiement complet par virement bancaire', NOW(), NOW(), NULL),
  (2, 4, 'CARD', 1200.00, '2024-01-25 16:00:00+01', 'Paiement complet par carte de crédit', NOW(), NOW(), NULL),
  (3, 6, 'BANK_TRANSFER', 1800.00, '2024-01-26 17:00:00+01', 'Paiement complet par virement bancaire', NOW(), NOW(), NULL),
  (4, 8, 'CARD', 2100.00, '2024-01-28 18:00:00+01', 'Paiement complet par carte de crédit', NOW(), NOW(), NULL),
  (5, 10, 'BANK_TRANSFER', 550.00, '2024-01-30 20:00:00+01', 'Paiement complet par virement bancaire', NOW(), NOW(), NULL),
  
  (6, 12, 'CASH', 1000.00, '2024-02-01 10:00:00+01', 'Paiement partiel en espèces', NOW(), NOW(), NULL),
  (8, 16, 'CARD', 1800.00, '2024-02-03 12:00:00+01', 'Paiement complet par carte de crédit', NOW(), NOW(), NULL),
  (9, 18, 'BANK_TRANSFER', 2100.00, '2024-02-04 13:00:00+01', 'Paiement complet par virement bancaire', NOW(), NOW(), NULL),
  (10, 20, 'CASH', 550.00, '2024-02-05 14:00:00+01', 'Paiement complet en espèces', NOW(), NOW(), NULL),


-- ==================================================
--           Maintenance des Camions
-- ==================================================

INSERT INTO truck_maintenances (id, truck_id, maintenance_date, description, cost, created_at, updated_at, deleted_at) VALUES
  (1, 1, '2024-02-01 08:00:00+01', 'Vidange et changement des filtres', 250.00, NOW(), NOW(), NULL),
  (2, 2, '2024-02-05 09:30:00+01', 'Remplacement des pneus', 800.00, NOW(), NOW(), NULL),
  (3, 3, '2024-02-10 10:15:00+01', 'Révision complète du moteur', 1500.00, NOW(), NOW(), NULL),
  (4, 4, '2024-02-15 11:45:00+01', 'Inspection des freins', 300.00, NOW(), NOW(), NULL),
  (5, 5, '2024-02-20 13:20:00+01', 'Remplacement de la batterie', 200.00, NOW(), NOW(), NULL),
  
  (6, 6, '2024-02-25 14:50:00+01', 'Nettoyage du système de refroidissement', 180.00, NOW(), NOW(), NULL),
  (7, 7, '2024-03-01 16:10:00+01', 'Remplacement des filtres à air', 150.00, NOW(), NOW(), NULL),
  (8, 8, '2024-03-05 17:30:00+01', 'Vérification du système électrique', 220.00, NOW(), NOW(), NULL),
  (9, 9, '2024-03-10 18:45:00+01', 'Réparation des phares', 100.00, NOW(), NOW(), NULL),
  (10, 10, '2024-03-15 20:00:00+01', 'Remplacement des courroies', 350.00, NOW(), NOW(), NULL),
  
  -- Maintenances 11 à 1000
  (11, 11, '2024-03-20 08:00:00+01', 'Changement des liquides de frein', 200.00, NOW(), NOW(), NULL),
  (12, 12, '2024-03-25 09:30:00+01', 'Remplacement des bougies d allumage', 180.00, NOW(), NOW(), NULL),
  (13, 13, '2024-04-01 10:15:00+01', 'Réparation du système de transmission', 500.00, NOW(), NOW(), NULL);

-- ==================================================
--                 KPI Snapshots
-- ==================================================

INSERT INTO kpi_snapshots (id, company_id, period_start, period_end, total_orders, on_time_deliveries, late_deliveries, total_revenue, total_costs, created_at) VALUES
  (1, 1, '2024-01-01', '2024-01-31', 50, 45, 5, 150000.00, 50000.00, NOW()),
  (2, 1, '2024-02-01', '2024-02-29', 60, 55, 5, 180000.00, 60000.00, NOW()),
  (3, 1, '2024-03-01', '2024-03-31', 55, 50, 5, 165000.00, 55000.00, NOW()),
  (4, 1, '2024-04-01', '2024-04-30', 65, 60, 5, 195000.00, 65000.00, NOW()),
  (5, 1, '2024-05-01', '2024-05-31', 70, 65, 5, 210000.00, 70000.00, NOW()),
  (6, 1, '2024-06-01', '2024-06-30', 75, 70, 5, 225000.00, 75000.00, NOW()),
  (7, 1, '2024-07-01', '2024-07-31', 80, 75, 5, 240000.00, 80000.00, NOW()),
  (8, 1, '2024-08-01', '2024-08-31', 85, 80, 5, 255000.00, 85000.00, NOW()),
  (9, 1, '2024-09-01', '2024-09-30', 90, 85, 5, 270000.00, 90000.00, NOW()),
  (10, 1, '2024-10-01', '2024-10-31', 95, 90, 5, 285000.00, 95000.00, NOW()),
  
  (11, 1, '2024-11-01', '2024-11-30', 100, 95, 5, 300000.00, 100000.00, NOW()),
  (12, 1, '2024-12-01', '2024-12-31', 105, 100, 5, 315000.00, 105000.00, NOW());

-- ==================================================
--                Notifications
-- ==================================================

INSERT INTO notifications (id, company_id, user_id, notification_type, message, is_read, created_at, updated_at, deleted_at) VALUES
  (1, 1, 1, 'INVOICE_OVERDUE', 'La facture INV-0005 est en retard de paiement.', FALSE, NOW(), NOW(), NULL),
  (2, 1, 2, 'LOW_STOCK', 'Le stock de UltraWidget 3000 est faible.', FALSE, NOW(), NOW(), NULL),
  (3, 1, 3, 'TRUCK_MAINTENANCE', 'Le camion AB-123-CD nécessite une maintenance prochaine.', FALSE, NOW(), NOW(), NULL),
  (4, 1, 4, 'ORDER_DELIVERY', 'La commande ID 10 a été livrée avec succès.', TRUE, NOW(), NOW(), NULL),
  (5, 1, 5, 'NEW_ORDER', 'Nouvelle commande ID 21 reçue.', FALSE, NOW(), NOW(), NULL),
  
  (6, 1, 6, 'INVOICE_OVERDUE', 'La facture INV-0010 est en retard de paiement.', FALSE, NOW(), NOW(), NULL),
  (7, 1, 7, 'LOW_STOCK', 'Le stock de FlexiPack 100 est faible.', FALSE, NOW(), NOW(), NULL),
  (8, 1, 8, 'TRUCK_MAINTENANCE', 'Le camion EF-456-GH nécessite une maintenance prochaine.', FALSE, NOW(), NOW(), NULL),
  (9, 1, 9, 'ORDER_DELIVERY', 'La commande ID 30 a été livrée avec succès.', TRUE, NOW(), NOW(), NULL),
  (10, 1, 10, 'NEW_ORDER', 'Nouvelle commande ID 31 reçue.', FALSE, NOW(), NOW(), NULL),
  
  -- Notifications 11 à 500
  (11, 1, 11, 'INVOICE_OVERDUE', 'La facture INV-0015 est en retard de paiement.', FALSE, NOW(), NOW(), NULL),
  (12, 1, 12, 'LOW_STOCK', 'Le stock de CargoExpress 1700 est faible.', FALSE, NOW(), NOW(), NULL),
  (13, 1, 13, 'TRUCK_MAINTENANCE', 'Le camion IJ-789-KL nécessite une maintenance prochaine.', FALSE, NOW(), NOW(), NULL),
  (14, 1, 14, 'ORDER_DELIVERY', 'La commande ID 40 a été livrée avec succès.', TRUE, NOW(), NOW(), NULL),
  (15, 1, 15, 'NEW_ORDER', 'Nouvelle commande ID 41 reçue.', FALSE, NOW(), NOW(), NULL);

COMMIT;
