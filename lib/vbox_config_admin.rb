# -*- coding: utf-8 -*-

require 'fileutils'

#
# require VBoxManage executable binary
#

class VboxConfigAdmin
  VERSION = '0.0.2'

  def version
    cmdline = "#{manager} --version"
    `#{cmdline}`.strip
  end

  def machine_base
    return File.join( vm_root, 'Machines' )
  end

  def vm_root
    home = ENV['HOME']
    ['Library/VirtualBox', '.VirtualBox'].each { |dir|
      d = File.join( home, dir )
      if ( File.exist?( d ) and File.directory?( d ) )
        return d
      end
    }
  end

  def machines
    cmdline = "#{manager} list vms"
    `#{cmdline}`.split( /(\r\n|[\r\n])/ ).map { |e|
      e.strip.match( /\A"(.+)" \{[0-9a-z-]+\}\z/ )
      $1
    }.compact.sort
  end

  #
  # VBoxManage binary
  #
  def manager
    @manager

    if ( !@manager )
      if ( RUBY_PLATFORM =~ /win/ and RUBY_PLATFORM !~ /darwin/ )
        @manager = which( 'VBoxManage.exe',
                          'C:\Program Files\Sun\xVM VirtualBox' )
      else
        @manager = 'VBoxManage'
      end
    end

    return @manager
  end

  def config_file( machine = nil )
    if ( machine )
      file = File.join( machine_base, machine, "#{machine}.xml" )
    else
      file = File.join( vm_root, 'VirtualBox.xml' )
    end

    return ( File.exist?( file ) and File.file?( file ) ) ? file : nil
  end

  def create_backup( machine = nil )
    return FileUtils.cp( config_file( machine ), backup_file( machine ) )
  end

  def backup_file( machine = nil )
    return config_file( machine ) +
      '.bak' + Time.now.strftime( "%Y%m%d%H%M%S" ) + '.txt'
  end

  def backup_files( machine = nil )
    path = File.dirname( config_file( machine ) )
    return Dir.chdir( path ) {
      Dir.glob( File.basename( config_file( machine ) ) +
                '.bak[0-9]*.txt' ).map { |f|
        File.join( path, f )
      }
    }
  end

  def clear_backups( machine = nil )
    if ( machine )
      backup_files( machine ).map { |e|
        FileUtils.rm( e )
      }
    else
      backup_files.map { |e|
        FileUtils.rm( File.join( vm_root, e ) )
      }
    end
  end

  def open( file )
    cmd = open_cmd
    if ( cmd )
      system( cmd, file )
    else
      # for Windows. Cannot open #{Machine}.xml, why ?
      system( 'cmd.exe /c "' + file + '"' )
    end
  end

  def open_config( machine )
    open( config_file( machine ) )
  end

  def open_latest_backup( machine )
    file = backup_files( machine ).sort.last
    if ( file )
      open( file )
    else
      puts "No backup."
    end
  end

  def getextradata( machine )
    call4vm( machine, 'getextradata', 'enumerate' )
  end

  private
  def call4vm( machine, subcommand, *params )
    if ( machines.include?( machine ) )
      machine = '"' + machine + '"' if ( machine.include?(' ') )
      cmdline = "#{manager} #{subcommand} #{machine} #{params.join(' ')}"
      puts cmdline
      `#{cmdline}`
    end
  end

  def open_cmd
    cmd = nil

    if ( ENV['EDITOR'] )
      cmd = ENV['EDITOR']
    else
      cmd = %w( gnome-open open start.com ).map { |cmd|
        ( which( cmd ) ) ? cmd : nil
      }.compact.first
    end

    return cmd
  end
end

def which( cmd, *additional )
  paths = ENV['PATH'].split( File::PATH_SEPARATOR )
  if ( additional )
    paths += additional
  end
  
  return paths.map { |path|
    file = File.join( path, cmd )
    ( File.exist?( file ) ) ? file : nil
  }.compact.first
end
