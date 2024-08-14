CREATE TABLE USER_ID_CARD (
                            id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                            code VARCHAR(255),
                            issue_date TIMESTAMPTZ,
                            expiry_date TIMESTAMPTZ,
                            title VARCHAR(255)
);

CREATE TABLE USER_DATA (
                           id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                           card_id UUID UNIQUE,
                           first_name VARCHAR(255),
                           middle_name VARCHAR(255),
                           last_name VARCHAR(255),
                           call_sign VARCHAR(255),
                           email VARCHAR(255),
                           phone_number VARCHAR(255),
                           image_url VARCHAR(255),
                           FOREIGN KEY (card_id) REFERENCES USER_ID_CARD(id)
);

CREATE TABLE CERTIFICATE (
                          id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                          user_id UUID,
                          number VARCHAR(255),
                          FOREIGN KEY (user_id) REFERENCES USER_DATA(id)
);

CREATE TABLE PLACE(
                          id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                          address VARCHAR(255),
                          place_latitude DOUBLE PRECISION,
                          place_longitude DOUBLE PRECISION
);

CREATE TABLE FLIGHT_REQUEST (
                                id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                status VARCHAR(255),
                                started BOOLEAN,
                                _from TIMESTAMPTZ,
                                _to TIMESTAMPTZ,
                                uav_type VARCHAR(255),
                                uav_models TEXT[],
                                radius INTEGER,
                                height_from DOUBLE PRECISION,
                                height_to DOUBLE PRECISION,
                                flight_type VARCHAR(255),
                                under_influence_of_ew BOOLEAN,
                                comment TEXT,
                                instructor_call_sign VARCHAR(255),
                                user_id UUID,
                                place_id UUID,
                                certificate_id UUID,
                                FOREIGN KEY (user_id) REFERENCES USER_DATA(id),
                                FOREIGN KEY (certificate_id) REFERENCES CERTIFICATE(id),
                                FOREIGN KEY (place_id) REFERENCES PLACE(id)
);