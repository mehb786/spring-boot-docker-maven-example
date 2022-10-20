pipeline{
    agent{
        label 'slave'
    }
    tools {
              maven 'maven'
        }

    stages{
        stage("Git Checkout"){
            steps{
                git 'https://github.com/mehb786/spring-boot-docker-maven-example.git'
            }
        }
        stage("Unit Test and Integration Test"){
            steps{
                sh 'mvn clean test'
                
                
            jacoco()
            }
        }
        stage("Build the package and Sonar Analaysis "){
            steps{
                script{
                        sh 'mvn clean install'
                    withSonarQubeEnv(credentialsId: 'sonar') {
                        sh 'mvn clean package sonar:sonar'
                    }
                   
                }
            }
        }
        stage("Uploading to Nexus"){
            steps{
               script{
                  def readPomVersion=readMavenPom file: 'pom.xml'
                  def pom=readPomVersion.version.endsWith('SNAPSHOT') ? 'demo-snapshot' : 'demo-release'
                  
                  nexusArtifactUploader artifacts: [[artifactId: 'spring-boot-docker-maven', classifier: '', file: '/root/slave/workspace/java/target/sample.jar', type: 'jar']], credentialsId: 'nexus', groupId: 'com.javatechie', nexusUrl: '3.144.38.24:8081/', nexusVersion: 'nexus3', protocol: 'http', repository: pom, version: "${readPomVersion.version}"      
            }
        }
        }
        stage("Build the docker image and tag and Push to Hub and Run Container "){
            steps{
                script{
                    sh """ 
                        docker image  build -t $JOB_NAME:v1.$BUILD_ID .
                        docker image  tag  $JOB_NAME:v1.$BUILD_ID    mehb786/$JOB_NAME:v1.$BUILD_ID
                        docker image  tag  $JOB_NAME:v1.$BUILD_ID    mehb786/$JOB_NAME:latest
                        """
                    withCredentials([string(credentialsId: 'dockerhub-id', variable: 'dockerhub')]) {
                         sh  'docker login -u mehb786 -p "${dockerhub}" '
                        }
                    sh   ' docker image push   mehb786/$JOB_NAME:v1.$BUILD_ID'
                     sh   ' docker image push   mehb786/$JOB_NAME:latest'
                        sh   """
                         docker rmi  mehb786/$JOB_NAME:v1.$BUILD_ID
                          docker rmi  mehb786/$JOB_NAME:latest
                     
                           
                          docker run -d -ti --name demo -p 8088:8085  mehb786/$JOB_NAME:latest
                          
                          
                        
                        
                        
                        
                        
                        """
                    
                    
                    
                    
                    
                
                    
                }
            }
        }
        
        
        
        
        
        
        
        
        
    }
}
