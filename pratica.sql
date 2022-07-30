-------------------------------------------------

CREATE DATABASE "bank_db";

-------------------------------------------------
-- states

CREATE TABLE "states" (
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL
);

-------------------------------------------------
-- cities

CREATE TABLE "cities" (
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL,
  "stateId" INTEGER NOT NULL REFERENCES "states"("id")
);

-------------------------------------------------
-- customer

CREATE TABLE "customer" (
  "id" SERIAL PRIMARY KEY,
  "fullName" TEXT NOT NULL,
  "cpf" VARCHAR(11) NOT NULL UNIQUE,
  "email" TEXT NOT NULL UNIQUE,
  "password" TEXT NOT NULL
);

-------------------------------------------------
-- customerAddresses

CREATE TABLE "customerAddresses" (
  "id" SERIAL PRIMARY KEY,
  "customerId" INTEGER NOT NULL REFERENCES "customer"("id"),
  "street" TEXT NOT NULL,
  "number" INTEGER NOT NULL,
  "complement" TEXT NOT NULL,
  "postalCode" TEXT NOT NULL,
  "cityId" INTEGER NOT NULL REFERENCES "cities"("id")
);

-------------------------------------------------
-- ENUM for customerPhones "type"

CREATE TYPE TYPE_CUSTOMER_PHONE AS ENUM ('landline', 'mobile');

-------------------------------------------------
-- customerPhones

CREATE TABLE "customerPhones" (
  "id" SERIAL PRIMARY KEY,
  "customerId" INTEGER NOT NULL REFERENCES "customer"("id"),
  "number" TEXT NOT NULL UNIQUE,
  "type" TYPE_CUSTOMER_PHONE NOT NULL
);

-------------------------------------------------
-- bankAccount

CREATE TABLE "bankAccount" (
  "id" SERIAL PRIMARY KEY,
  "customerId" INTEGER NOT NULL REFERENCES "customer"("id"),
  "accountNumber" TEXT NOT NULL UNIQUE,
  "agency" TEXT NOT NULL,
  "openDate" DATE NOT NULL DEFAULT NOW(),
  "closeDate" DATE
);
-------------------------------------------------
-- ENUM for transactions "type"

CREATE TYPE TYPE_TRANSACTIONS AS ENUM ('deposit', 'withdraw');

-------------------------------------------------
-- bankAccount

CREATE TABLE transactions (
  "id" SERIAL PRIMARY KEY,
  "bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
  "amount" REAL NOT NULL,
  "type" TYPE_TRANSACTIONS NOT NULL,
  "time" TIMESTAMP NOT NULL,
  "description" TEXT NOT NULL,
  "cancelled" BOOLEAN NOT NULL DEFAULT FALSE
);

-------------------------------------------------
-- creditCards

CREATE TABLE "creditCards" (
  "id" SERIAL PRIMARY KEY,
  "bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
  "name" TEXT NOT NULL,
  "number" TEXT NOT NULL UNIQUE,
  "securityCode" TEXT NOT NULL,
  "expirationMonth" INTEGER NOT NULL,
  "expirationYear" INTEGER NOT NULL,
  "password" TEXT NOT NULL,
  "limit" REAL NOT NULL
);

-------------------------------------------------

