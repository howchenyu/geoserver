-- 
--  INTERACTIVE TESTING SQL SETUP FILE, CENTRAL SIDE
--

-- clean up the versioning tables
DROP TABLE tables_changed cascade;
DROP TABLE versioned_tables cascade;
DROP TABLE changesets cascade;
DROP TABLE roads cascade;
DROP TABLE archsites cascade;
DROP TABLE restricted cascade;

-- clean up GSS metadata tables
DROP TABLE synch_tables cascade;
DROP TABLE synch_history cascade;
DROP TABLE synch_conflicts cascade;
DROP TABLE synch_units cascade;
DROP TABLE synch_unit_tables cascade;

DELETE FROM geometry_columns;

-- restricted areas
CREATE TABLE restricted (gid uuid not null, cat bigint, the_geom geometry, CONSTRAINT enforce_dims_the_geom CHECK ((ndims(the_geom) = 2)), CONSTRAINT enforce_geotype_the_geom CHECK (((geometrytype(the_geom) = 'MULTIPOLYGON'::text) OR (the_geom IS NULL))), CONSTRAINT enforce_srid_the_geom CHECK ((srid(the_geom) = 26713)));
INSERT INTO restricted VALUES ('be7cafea-d0b7-4257-9b9c-1ed3de3f7ef4', 100, '010600002059680000010000000103000000010000000F000000B12300ACA41022416247EEDE68CA5241BE9BCFC3AA102241450CF30F69CA524142D685EFF9102241103405AE64CA52418DEAA17C841122412DB797705DCA52410278F37BD61222412D9359934ACA52411307E9A34F152241CCD300DC39CA5241DE2D7E9061152241BAC9F1F9E3C95241E58154B2D60D224148DB6304DCC952413D65F706D20D2241A7861F9CE2C95241CCC0F97DC70D2241983D0722F9C95241FF984477040E2241FF15B7DF02CA5241D29FE0DD1C0E2241600B2BCB08CA5241F513D540720F2241D5B7CF6433CA52410CC47A5C75102241FD44164E57CA5241B12300ACA41022416247EEDE68CA5241');
INSERT INTO restricted VALUES ('d91fe390-bdc7-4b22-9316-2cd6c8737ef5', 200, '010600002059680000010000000103000000010000000C000000CDF549523F1A224122FB812193C85241FD212A120B1A22415AD1E39694C9524172235BF7051D22411746781995C95241B0F492A39C1C2241519EAD8655C95241299738D7E81B22418593B53F39C952419D404A8ADC1B2241E62FA80B1CC95241DF72E803FE1A22411C9C219FE9C852415D8192CED11A22417C1D1297DDC852414BEA57AC8B1A2241E58EE902C8C85241C81988565C1A224105E474F0A7C85241EFCB16B1541A224131E605EC9FC85241CDF549523F1A224122FB812193C85241');
INSERT INTO restricted VALUES ('c15e76ab-e44b-423e-8f85-f6d9927b878a', 300, '0106000020596800000100000001030000000100000005000000AD873E30BF412241667C4CB215C2524115E1BC2DBA4C2241DC8AD54418C25241DFCC68F3D24C22416708C3D105C152415878070ADE412241DCFBBB3100C15241AD873E30BF412241667C4CB215C25241');
INSERT INTO restricted VALUES ('1b99be2b-2480-4742-ad52-95c294efda3b', 400, '0106000020596800000100000001030000000100000022000000CEDD3EE07913224156F146636FC65241F5EED830E22E2241C846562264C65241B8E65CEB5B2F2241DFB147295FC65241272EC951293022413A278DCA55C65241F43CCD7EEA302241844ECCF049C6524128256B9BCE3122419A0CC61F39C65241D694DA14923322414A9C1DFE0CC65241367131C14D35224189372DFBD5C55241795BDD9BC2352241FE568D41BFC552417786DC6A3F3722410106690D6FC55241E0DDE2A25A3822416981D8D616C55241F636EEEFBD382241E60BF089D1C45241E3CE1FE4BD382241868ACBDDCEC45241B102BCE0992B224113FA7BCC9CC15241646F5DE6C72A2241C678B498A5C1524183E5D97FB42922416B6D2674B1C1524123BB600D4F28224103711FA0C7C1524182F25DD01B2722413358A780DBC15241F5323917B623224124C64AEB23C25241FE70D6821C232241A028F72530C25241D8DBC22F08212241C30F41B253C25241AC8451D74F1E22411AE0AD1290C25241D1B5B5C05F1B22419BFB3F01EFC25241067313760D18224147DFCF9C7AC352416544BD1B3F172241DFAD9E01A5C352414C28C4EED41622410FA13AE0BCC35241B2F274F1531622410B2D3F46D6C352418391DC425314224157D9F73A49C45241C1E88CD0C4132241BA4951F270C452418C2C72CA83132241D61D7D1A8BC4524167C296D5F5122241BAA1CE7327C552411144399FF81222410279D4C070C55241BF21FC9C1113224182BCB966EDC55241CEDD3EE07913224156F146636FC65241');
ALTER TABLE ONLY restricted ADD CONSTRAINT restricted_pkey PRIMARY KEY (gid);
CREATE INDEX restricted_the_geom_gist ON restricted USING gist (the_geom);
INSERT INTO geometry_columns values ('', 'public', 'restricted', 'the_geom', 2, 26713, 'MULTIPOLYGON');


-- roads
CREATE TABLE roads (gid uuid NOT NULL, cat bigint, label character varying(80), the_geom geometry,  CONSTRAINT enforce_dims_the_geom CHECK ((ndims(the_geom) = 2)), CONSTRAINT enforce_geotype_the_geom CHECK (((geometrytype(the_geom) = 'MULTILINESTRING'::text) OR (the_geom IS NULL))), CONSTRAINT enforce_srid_the_geom CHECK ((srid(the_geom) = 26713)));
INSERT INTO roads VALUES ('80f3cd91-7ea4-42cb-b06d-f87dead4d57b', 5, 'unimproved road', '01050000205968000001000000010200000013000000DF41C3894C442241245E60A1E2BE52418EC8B9633B44224144CCBE55E9BE5241D59DDD5ABD43224156C6F1B013BF524115E5B1D4E3432241BDC880072BBF524148ECA8E883442241882BC61742BF524193C626DF00452241D4FD103851BF52415564D7DA064522414EF4946756BF524186C84C36F844224163AC3E2559BF52418A64C0DCF0442241E85A680A5CBF5241DD72FD42D7442241C143898A5FBF5241D59CF62B35442241E2FC762B73BF52411C3B4DC3C443224195939A1C90BF52410360B89EB3432241C10AE88296BF524154BF56FC2A432241F672656AAEBF5241EC02776512432241F8FDFCE4BCBF5241746C14CE09432241B6195F29C1BF524191FB4E5A88422241EC46A72ADFBF52416AAD81FC8C422241A0FDA584EBBF5241F4C1322A94422241FA989341EBBF5241');
INSERT INTO roads VALUES ('31ded233-3b42-46a9-a7d6-2a4336e87bf7', 5, 'unimproved road', '01050000205968000001000000010200000020000000680A19B1614422410CF653DB0EC0524189C4903C54442241786A661F13C05241DA9B10D50344224143B0052F1BC05241CB64593CC9432241A8E7F88427C052415CE49EA2B6432241307203E13AC05241762B32CF8A4322414C3ECF9C3DC052417E80DE178743224197135F4541C05241AB8D35C296432241E40F0AE648C05241BF8C39EA59432241671BAE524BC05241D269A30128432241C8D11E354EC0524128328C24294322412B3C207A52C052418130C7C327432241F0CEEF2A5BC052410288D4ABEF422241C4CB36B163C052416F034658FA422241F3D30F2E72C0524149DD8C5EE4422241DE55B0E676C05241FEF73B95B3422241EDDF4CD17EC052419FA2F2D68E422241B2510CFD8CC052419B9C90DE37422241297CF21EAFC0524168E091802B422241A18D963FBAC05241F47D6143254222419AFD0DC9C2C05241FAAAA62F20422241FB803A38CEC05241680C8C0D6A422241504D8DB4DEC05241439FB8BD3B422241436FD255E4C05241C5038828F5412241F219F95DE7C052417893E735904122415E25C88FE8C05241E4219D815A4122419531B65FF3C05241EBB4A80851402241F79D535908C15241AEFDB6181A40224106A5601314C15241896187350540224108C492A81FC15241A1662737174022415602752A2CC15241FE55D32945402241E1996D0D3AC15241E27F65308A4022414DE32C5149C15241');
INSERT INTO roads VALUES ('bc0be224-57ea-4978-a5c1-4b8cebaa5f84', 5, 'unimproved road', '01050000205968000001000000010200000008000000DE128846A13122410A9BC7230CC252410C77AAA9763122416CCCAF060FC2524179B7AA770B31224132BA0F3719C2524194E34684E5302241C9CFA1ED26C25241B192454CEC3022411493188742C25241416599AFD2302241B3695BA346C25241366AAEE685302241843F8B3950C252417CE24A277C302241FD50274A51C25241');
INSERT INTO roads VALUES ('d4368c10-3b55-48b5-a7b0-92f42426b8b1', 5, 'unimproved road', '0105000020596800000100000001020000000D0000007CE24A277C302241FD50274A51C25241BE7706734530224146CD7C8350C2524162F2CC62742F2241E7B5250A4CC25241E9B8B7A0FF2E2241F35CFA614DC25241D975350AC42E224107923BAC4DC25241A90CA915382E22410FC8AD0A54C25241D082ED61F02D2241A123A0E351C25241433DF919F62C224131C62EB246C2524167E587F7A02C22418EBAEF9647C2524106E56C58702C2241864CA0A946C2524105FFF826312C2241558826AA44C25241A9E4529BEF2B2241F46F97653EC2524155879AA4A02B22411287AC693AC25241');
INSERT INTO roads VALUES ('1f403a4e-833f-4adb-8fbe-cd420e284164', 5, 'unimproved road', '0105000020596800000100000001020000003A000000DE128846A13122410A9BC7230CC25241BAA67A09A63122418A9E48A111C2524162250FC79431224124DBF1471EC25241DA4DB6BEB631224111EF0C8F22C25241262EAE08243222416737C6832AC25241EA10CDD411332241BD6B371647C25241AB49C7BB02342241627838C880C25241BC4E13E348342241939E12C694C252419D913188D0342241AC061DEEB1C25241775834EFFA3422418E84A853BAC2524184D4500F0835224143006EBFC7C2524182802907C0342241EC4B3848D7C252416F556533B6342241FCDDC19DDCC252412552A236183522416559A868F6C252415341C1CA05352241A2829C2900C352414BB39253D13422411A9D5AC109C352410EBF59B0B7342241CACAE93C0FC352412FD8B2FF81342241C26DAD4919C35241303D69D8433422414E7955BE20C352415E8CBB76F333224182E3B09527C35241EA93FD1B4A332241B4D3C98839C35241D41D17071D3322413E76F8663EC3524119BECF74D63222411C33FDD240C3524199E0ED9AF6312241C06B00DE46C3524116F1C66F253122410A2CE30848C3524128B383E405312241235E093744C35241ACA8C10AEA3022418896E3F43DC35241DB19A6F0B0302241BA75AB593BC35241FE5F759E333022410F668D6F3FC352413533C84FE82F22415CC8C4FE3AC35241A7E4620B642F224167ED1B532CC35241180797D2162F22414CB823220CC352416E6E4CF72A2F2241E9A25D3DE7C25241EC223B7F212F22415772BA5CD9C2524109BD8299262F2241F097418ECCC252418E5E8925072F2241AC5B58DBC3C2524190302DC29E2E2241D17580EBB9C25241CA0CA7C0D62E2241BC5962BBB6C252411F5D956B562F22418AB4A638B7C25241CF4D59B7A12F22410F409145BCC252416CEA1B2EF32F2241C469D898BCC25241A9B9813155312241BFC386B0B3C25241F0D1EA67893122414094BBAAB7C252417453F39A963122414786A41FC1C25241E863E3B6B4312241F38BF7AED0C252415E2D56F2E23122418CEA9F52CFC252413ED4CFBA0732224176B86904BFC2524141A43AF85A3222418ACC3D4EA1C25241E1B26D01823222416DCF459B9AC252412CB1D77E5C3222416826B5AF90C252415B069CA71E3222418226B85E87C2524107393961AB3122412C6383617AC25241D4266F7A57312241A65C255C7AC25241A60B903A23312241FCD05E5D78C25241DFF987C5E730224162D719A471C2524115B8A7279F3022417B2B75535FC252412F30AF407730224181EE454553C252417CE24A277C302241FD50274A51C25241');
ALTER TABLE ONLY roads ADD CONSTRAINT roads_pkey PRIMARY KEY (gid);
CREATE INDEX roads_the_geom_gist ON roads USING gist (the_geom);
INSERT INTO geometry_columns values ('', 'public', 'roads', 'the_geom', 2, 26713, 'MULTILINESTRING');

-- Archsites
CREATE TABLE archsites (gid uuid NOT NULL, cat bigint, str1 character varying(80), the_geom geometry, CONSTRAINT enforce_dims_the_geom CHECK ((ndims(the_geom) = 2)), CONSTRAINT enforce_geotype_the_geom CHECK (((geometrytype(the_geom) = 'POINT'::text) OR (the_geom IS NULL))), CONSTRAINT enforce_srid_the_geom CHECK ((srid(the_geom) = 26713)));
INSERT INTO archsites VALUES ('f576a55e-2043-4765-906c-ab79823e0503', 1, 'Signature Rock', '01010000205968000000000000AA1C2241000000808ABF5241');
INSERT INTO archsites VALUES ('78c1616a-33f8-4e5a-8b55-cbc9b269a190', 2, 'No Name', '010100002059680000000000009C102241000000009EC75241');
INSERT INTO archsites VALUES ('550a0d02-9028-4db8-a665-b705dc642ebc', 3, 'Canyon Station', '010100002059680000000000004800224100000000A4C65241');
INSERT INTO archsites VALUES ('ae834070-9cc2-4d5d-a5fa-791236d828ef', 4, 'Spearfish Creek', '01010000205968000000000000800422410000000071C75241');
ALTER TABLE ONLY archsites ADD CONSTRAINT archsites_pkey PRIMARY KEY (gid);
CREATE INDEX archsites_the_geom_gist ON archsites USING gist (the_geom);
INSERT INTO geometry_columns values ('', 'public', 'archsites', 'the_geom', 2, 26713, 'POINT');

-- Setup versioning 
CREATE TABLE synch_tables(
  table_id SERIAL PRIMARY KEY, 
  table_name VARCHAR(256) NOT NULL, 
  type CHAR(1) NOT NULL CHECK (type in ('p', 'b', '2'))
);

CREATE TABLE synch_units (
  unit_id SERIAL PRIMARY KEY,
  unit_name VARCHAR(1024) NOT NULL,
  unit_address VARCHAR(2048) NOT NULL,
  synch_user VARCHAR(256),
  synch_password VARCHAR(256),
  time_start TIME,
  time_end TIME,
  synch_interval INTEGER,
  synch_retry INTEGER,
  errors BOOLEAN
);
SELECT AddGeometryColumn('synch_units','geom',4326,'GEOMETRY',2);

CREATE TABLE synch_unit_tables (
   id SERIAL PRIMARY KEY,   
   unit_id INTEGER NOT NULL REFERENCES synch_units(unit_id),
   table_id INTEGER NOT NULL REFERENCES synch_tables(table_id),
   last_synchronization TIMESTAMP,
   last_failure TIMESTAMP,
   getdiff_central_revision BIGINT,
   last_unit_revision BIGINT,
   unique (unit_id, table_id)
);

CREATE VIEW synch_outstanding 
AS SELECT synch_tables.*, 
          synch_units.*, 
          synch_unit_tables.last_synchronization,
          synch_unit_tables.last_failure, 
          synch_unit_tables.getdiff_central_revision, 
          synch_unit_tables.last_unit_revision
FROM (synch_units inner join synch_unit_tables 
                  on synch_units.unit_id = synch_unit_tables.unit_id)
     inner join synch_tables 
     on synch_tables.table_id = synch_unit_tables.table_id
WHERE ((time_start < LOCALTIME AND LOCALTIME < time_end) 
        OR (time_start IS NULL) OR (time_end IS NULL))
      AND ((now() - last_synchronization > synch_interval * interval '1 minute') 
        OR last_synchronization IS NULL)
      AND (last_failure is null OR           now() - last_failure > synch_retry * interval '1 minute');
INSERT INTO geometry_columns VALUES('', 'public', 'synch_outstanding', 'geom', 2, 4326, 'GEOMETRY');
  
-- Mark tables as synchronized. The other metadata tables will be filled 
-- as the protocol starts rolling
INSERT INTO synch_tables VALUES(nextval('synch_tables_table_id_seq'), 'restricted', '2');
INSERT INTO synch_tables VALUES(nextval('synch_tables_table_id_seq'), 'roads', '2');
INSERT INTO synch_tables VALUES(nextval('synch_tables_table_id_seq'), 'archsites', '2');  

-- setup two units, they will synch up every minute (actually using 0.5, thirty seconds, to make sure all layers will synch up when the
-- synch loop checks for unsynchronised tables, which happens once per minute)
INSERT INTO synch_units VALUES(nextval('synch_units_unit_id_seq'), 'unit1', 'http://localhost:8081/geoserver/ows', null, null, null, null, 0.5, 1, false);
INSERT INTO synch_units VALUES(nextval('synch_units_unit_id_seq'), 'unit2', 'http://localhost:8082/geoserver/ows', null, null, null, null, 0.5, 1, false);

-- setup the layers for the two units
INSERT INTO synch_unit_tables(unit_id, table_id) VALUES(1, 1);
INSERT INTO synch_unit_tables(unit_id, table_id) VALUES(1, 2);
INSERT INTO synch_unit_tables(unit_id, table_id) VALUES(1, 3);
INSERT INTO synch_unit_tables(unit_id, table_id) VALUES(2, 1);
INSERT INTO synch_unit_tables(unit_id, table_id) VALUES(2, 2);
INSERT INTO synch_unit_tables(unit_id, table_id) VALUES(2, 3);