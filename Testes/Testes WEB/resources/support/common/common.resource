*** Settings ***
Documentation    Ações comuns dos cenários de teste

Library          Browser
Library          FakerLibrary
Library          Collections
Library          ../libs/database.py

Resource         ../common/env.resource 
Resource         ../fixtures/dynamics.resource
Resource         ../../pages/HomePage.robot 
Resource         ../../pages/LoginPage.resource
Resource         ../../pages/MoviesPage.resource
Resource         ../../pages/RegisterPage.resource
Resource         ../../pages/ProfilePage.resource
Resource         ../../pages/components/Alert.resource

*** Keywords ***
Criar Sessao
    New Browser    browser=${BROWSER}    headless=False
    New Page       ${BASE_URL}